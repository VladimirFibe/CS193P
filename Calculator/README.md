#  Calculator

```
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
```

```
import UIKit

struct CalculatorBrain {
    private var accumulator: Double?

    mutating func perforOperation(_ symbol: String) {
        switch symbol {
        case "𝝿":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

    var result: Double? {
        accumulator
    }
}

#Preview {
    CalculatorViewController()
}
```

```
    private var operations: Dictionary<String, Double> = [
        "𝝿": Double.pi,
        "e": M_E
    ]
    
    mutating func perforOperation(_ symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
    }
```

```
    private enum Operation {
        case constant(Double)
    }
    private var operations: Dictionary<String, Operation> = [
        "𝝿": .constant(Double.pi),
        "e": .constant(M_E)
    ]
    
    mutating func perforOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value): accumulator = value
            }
        }
    }
```

```
    private func setupButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: [])
        button.backgroundColor = .systemFill
        button.tintColor = .label
        if title <= "9" {
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
```

