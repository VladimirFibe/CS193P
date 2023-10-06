import UIKit

class ViewController: UIViewController {
    private let faceView = {
        $0.contentMode = .redraw
        return $0
    }(FaceView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(faceView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        faceView.frame = view.layoutMarginsGuide.layoutFrame
    }
}

