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

    private func fetchImage() {
        if let url = imageURL {
            if let urlContents = try? Data(contentsOf: url) {
                image = UIImage(data: urlContents)
            }
        }
    }

    private var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
