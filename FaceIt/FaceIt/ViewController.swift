import UIKit

class ViewController: UIViewController {
    private lazy var faceView = {
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(changeScale))
        $0.addGestureRecognizer(pinchRecognizer)
        $0.backgroundColor = .systemBackground
        $0.contentMode = .redraw
        return $0
    }(FaceView())

    @objc func changeScale(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .changed, .ended:
            faceView.scale *= sender.scale
            sender.scale = 1
        default: break
        }
    }
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet { updateUI() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(faceView)
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        faceView.frame = view.layoutMarginsGuide.layoutFrame

    }

    private func updateUI() {
        faceView.configure(
            with: expression.eyes == .open,
            mouthCurvature: mouthCurvatures[expression.mouth] ?? 0.0
        )
    }

    private let mouthCurvatures: [FacialExpression.Mouth: Double] = [
        .smile:     1.0,
        .grin:      0.5,
        .neutral:   0.0,
        .smirk:     -0.5,
        .frown:     -1.0
    ]
}

