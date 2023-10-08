import UIKit

class FaceViewController: VCLLoggingViewController {
    private lazy var faceView = {
        let handler = #selector(FaceView.changeScale)
        let pinchRecognizer = UIPinchGestureRecognizer(target: $0, action: handler)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes))
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
        swipeUpRecognizer.direction = .up
        swipeDownRecognizer.direction = .down
        tapRecognizer.numberOfTapsRequired = 1
        $0.addGestureRecognizer(pinchRecognizer)
        $0.addGestureRecognizer(tapRecognizer)
        $0.addGestureRecognizer(swipeUpRecognizer)
        $0.addGestureRecognizer(swipeDownRecognizer)
        $0.backgroundColor = .systemBackground
        $0.contentMode = .redraw
        return $0
    }(FaceView())

    @objc func increaseHappiness() {
        expression.increaseHappiness()
    }

    @objc func decreaseHappiness() {
        expression.decreaseHappiness()
    }

    @objc func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            expression.toggleEyes()
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

