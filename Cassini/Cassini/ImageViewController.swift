import UIKit

class ImageViewController: UIViewController {
    var imageURL: URL? {
        didSet {
            imageView.image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

    @IBOutlet weak var imageView: UIImageView!

    private func fetchImage() {
        if let url = imageURL {
            if let urlContents = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: urlContents)
            }
        }
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
