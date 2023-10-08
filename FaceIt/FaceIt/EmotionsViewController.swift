import UIKit

class EmotionsViewController: VCLLoggingViewController {
    private lazy var stackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        ["Sad", "Happy", "Worried"].forEach {
            let button = UIButton(type: .system)
            button.titleLabel?.font = .systemFont(ofSize: 40)
            button.setTitle($0, for: [])
            button.addTarget(self, action: #selector(buttonHandler), for: .primaryActionTriggered)
            stackView.addArrangedSubview(button)
        }
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    @objc private func buttonHandler(_ sender: UIButton) {
        if let title = sender.currentTitle,
           let expression = emotionalFaces[title] {
            let controller = FaceViewController()
            controller.expression = expression
            controller.navigationItem.title = title
            splitViewController?.showDetailViewController(UINavigationController(rootViewController: controller), sender: self)
        }
    }

    private let emotionalFaces: [String: FacialExpression] = [
        "Sad": FacialExpression(eyes: .closed, mouth: .frown),
        "Happy": FacialExpression(eyes: .open, mouth: .smile),
        "Worried": FacialExpression(eyes: .open, mouth: .smirk)
    ]
}
