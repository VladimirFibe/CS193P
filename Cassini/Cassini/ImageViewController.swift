import UIKit

class ImageViewController: UIViewController {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

    lazy var scrollView: UIScrollView = {
        view.addSubview($0)
        $0.minimumZoomScale = 1/25
        $0.maximumZoomScale = 1.0
        $0.delegate = self
        $0.addSubview(imageView)
        return $0
    }(UIScrollView())

    var imageView: UIImageView = {
        return $0
    }(UIImageView())

    lazy var spinner: UIActivityIndicatorView = {
        view.addSubview($0)
        $0.hidesWhenStopped = true
        $0.style = .large
        $0.color = .systemBlue
        return $0
    }(UIActivityIndicatorView())

    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let imageData = try? Data(contentsOf: url), 
                         url == self?.imageURL else { return }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: imageData)
                }

            }
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                guard let data else { return }
//                let image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//
//            }
//            task.resume()
        }
    }

    var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
            spinner.stopAnimating()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        spinner.center = view.center
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
