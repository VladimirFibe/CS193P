//
//  QRCodeScannerViewController.swift
//  PlayingCard
//
//  Created by Vladimir Fibe on 30.08.2023.
//

import UIKit
import AVFoundation
import SnapKit

class QRCodeScannerViewController: UIViewController {

    // 1. Настроим сессию
//    var delegate: TabBarControllerProtocol?

    // MARK: - Private Variables -

    private let session = AVCaptureSession()

    private var video = AVCaptureVideoPreviewLayer()

    // запихали в топбар верхние элементы для удобства
    private lazy var topbar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var scanQRLabel: UILabel = {
        let label = UILabel()
        label.text = "Сканировать QR"
        return label
    }()

    // кнопка Закрыть кьюар
    private lazy var closeIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(
            self,
            action: #selector(closeVC),
            for: .touchUpInside
        )
        return button
    }()

    // Рамка для определения qr-code_а синяя
    private lazy var scanSquareImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square")
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.image?.withRenderingMode(.alwaysOriginal)
        imageView.image?.withTintColor(UIColor(red: 51, green: 51, blue: 51, alpha: 1))
        imageView.tintColor = .yellow
        return imageView
    }()

    private lazy var spinner = UIActivityIndicatorView(style: .large)

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Ошибка при сканировании.
        Попробуйте еще раз
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupVideo()
        startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        session.stopRunning()
    }

    @objc private func closeVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            print("QR closed")
        })
    }

    // MARK: - Setup -

    private func setupVideo() {
        // 2. Настраиваем устройство видео
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("device not found")
            return
        }

        // 3. Настроим input
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }

        // 4. Настроим output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)

        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        video.videoGravity = .resizeAspectFill
    }

    // начинается видео
    private func startRunning() {
        view.layer.insertSublayer(video, at: 0)

        session.startRunning()
    }

    private func setupViews() {
        view.addSubview(topbar)
        topbar.addSubview(scanQRLabel)
        topbar.addSubview(closeIcon)
        view.addSubview(scanSquareImage)
        view.addSubview(spinner)
        view.addSubview(errorLabel)
        view.backgroundColor = .systemBackground
        spinner.isHidden = true
        scanSquareImage.isHidden = false
    }

    private func qrStartLoading(completion: @escaping (Bool) -> Void) {
        spinner.color = .black
        spinner.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        spinner.startAnimating()
        scanSquareImage.isHidden = true
        spinner.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(true)
            self.spinner.isHidden = true
        }
    }

    private func openNewVC() {
        self.dismiss(animated: true) {
            // openMenu
            print("dismiss")
        }
    }

    private func errorOccured() {
        errorLabel.isHidden = false
        scanSquareImage.isHidden = false
    }

    private func setupConstraints() {
        topbar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(66)
        }
        closeIcon.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalToSuperview().offset(26)
            $0.right.equalToSuperview().offset(-26)
        }
        scanQRLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(20)
        }
        scanSquareImage.snp.makeConstraints {
            $0.size.equalTo(500)
            $0.center.equalToSuperview()
        }
        spinner.snp.makeConstraints {
            $0.size.equalTo(72)
            $0.center.equalToSuperview()
        }
        errorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scanQRLabel.snp.bottom).offset(90)
        }
    }
}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                print(object.stringValue ?? "no code")
            }
        }
    }
}
