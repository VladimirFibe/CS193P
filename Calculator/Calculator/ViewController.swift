import UIKit

class ViewController: UIViewController {
    private let displayLabel = UILabel()
    private let calculatorStackView = UIStackView()
    private var userIsInTheMiddleOfTyping = false
    private var zeroButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .perecent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .point, .equals]
    ]

    private func setupViews() {
        view.backgroundColor = .systemBackground
        setupCalculatorStackView()
        setDislplayLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let width = zeroButton.titleLabel?.intrinsicContentSize.width else { return }
        let height = zeroButton.frame.height
        zeroButton.configuration?.contentInsets = .init(
            top: 0, leading: (height - width) / 2, bottom: 0, trailing: 0)
    }

    private func setupCalculatorStackView() {
        view.addSubview(calculatorStackView)
        calculatorStackView.addArrangedSubview(displayLabel)
        calculatorStackView.axis = .vertical
        let spacing = 15.0
        calculatorStackView.spacing = spacing

        let lastStackView = UIStackView()
        lastStackView.spacing = spacing
        lastStackView.distribution = .fillEqually
        for row in buttons {
            let rowStackView = UIStackView()
            rowStackView.spacing = spacing
            rowStackView.distribution = .fillEqually
            for item in row {
                let button = setupButton(with: item)
                rowStackView.addArrangedSubview(button)
                switch item {
                case .point: lastStackView.addArrangedSubview(button)
                case .equals:
                    lastStackView.addArrangedSubview(button)
                    rowStackView.addArrangedSubview(lastStackView)
                default: rowStackView.addArrangedSubview(button)
                }
                if item != .zero {
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                } else {
                    button.contentHorizontalAlignment = .leading
                    zeroButton = button
                }
            }
            calculatorStackView.addArrangedSubview(rowStackView)
        }
        calculatorStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calculatorStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            calculatorStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            calculatorStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func setupButton(with button: CalculatorButton) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        var attributes = AttributeContainer()
        let size = UIScreen.main.bounds.width / 10
        attributes.font = UIFont.systemFont(ofSize: size)
        let attributedTitle = AttributedString(button.title, attributes: attributes)

        configuration.attributedTitle = attributedTitle
        configuration.baseBackgroundColor = button.backgroundColor
        configuration.baseForegroundColor = button.foregroundColor
        configuration.cornerStyle = .capsule
        return UIButton(
            configuration: configuration,
            primaryAction: UIAction(handler: {[weak self] action in
                switch button {
                case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine: self?.touchDigit(with: button.title)
                default: self?.performOperation(with: button.title)
                }
            })
        )
    }

    private func setDislplayLabel() {
        let textString = "0"
        let font = UIFont.systemFont(
            ofSize: UIScreen.main.bounds.width / 4,
            weight: .light
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tailIndent = -20
        paragraphStyle.alignment = .right
        let attibutes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.label,
            .paragraphStyle: paragraphStyle
        ]
        displayLabel.attributedText = NSMutableAttributedString(
            string: textString, attributes: attibutes)
    }

    private func touchDigit(with digit: String) {
        let textCurrentlyInDisplay = displayLabel.text ?? ""
        if userIsInTheMiddleOfTyping {
            displayLabel.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private func performOperation(with symbol: String) {
        userIsInTheMiddleOfTyping = false
        switch symbol {
        case "%": displayLabel.text = String(Double.pi)
        default: displayLabel.text = "0"
        }
    }

}

#Preview {
    ViewController()
}
