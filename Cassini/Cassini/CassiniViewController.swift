import UIKit

class CassiniViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
              let url = DemoURLs.NASA[identifier],
        let imageViewController = segue.destination.contents as? ImageViewController
        else { return }
        imageViewController.imageURL = url
        imageViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
    }

}

extension UIViewController {
    var contents: UIViewController {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController ?? self
        } else {
            return self
        }
    }
}
