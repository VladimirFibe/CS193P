import UIKit

final class CalculatorViewController: UIViewController {

    private let stackView = UIStackView()
    private let displayLabel = UILabel()
    private let headerView = UIView()
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stackView.frame = view.layoutMarginsGuide.layoutFrame
    }

    let titles = [
        ["e", "√", "cos", "𝝿"],
        ["C", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        let spacing = 15.0
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(displayLabel)
        displayLabel.text = "0"
        displayLabel.font = .systemFont(ofSize: 60)
        displayLabel.adjustsFontSizeToFitWidth = true
        displayLabel.minimumScaleFactor = 0.5
        let lastStackView = UIStackView()
        lastStackView.spacing = spacing
        lastStackView.distribution = .fillEqually
        for row in titles {
            let rowStackView = UIStackView()
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = spacing
            for title in row {
                let button = setupButton(with: title)
                switch title {
                case ".": lastStackView.addArrangedSubview(button)
                case "=":
                    lastStackView.addArrangedSubview(button)
                    rowStackView.addArrangedSubview(lastStackView)
                default: rowStackView.addArrangedSubview(button)
                }
                if title != "0" {
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                }
            }
            stackView.addArrangedSubview(rowStackView)
        }
    }

    private func setupButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: [])
        button.titleLabel?.font = .systemFont(ofSize: 40)
        button.backgroundColor = .systemFill
        button.tintColor = .label
        if (title >= "0" && title <= "9") || title == "." {
            button.addTarget(
                self,
                action: #selector(touchDigit),
                for: .primaryActionTriggered
            )
        } else {
            button.addTarget(
                self,
                action: #selector(performOperation),
                for: .primaryActionTriggered
            )
        }
        return button
    }

    var displayValue: Double {
        get {
            Double(displayLabel.text ?? "0") ?? 0
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @objc private func performOperation(_ sender: UIButton) {
        guard let symbol = sender.currentTitle else { return }
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        brain.perforOperation(symbol)
        if let result = brain.result {
            displayValue = result
        }
    }

    @objc private func touchDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        let textCurrentlyInDisplay = displayLabel.text ?? ""
        if digit == "." {
            if !textCurrentlyInDisplay.contains(".") {
                displayLabel.text = textCurrentlyInDisplay + digit
                userIsInTheMiddleOfTyping = true
            }
        } else if userIsInTheMiddleOfTyping {
            displayLabel.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
}

#Preview {
    CalculatorViewController()
}
