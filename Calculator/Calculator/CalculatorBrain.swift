import UIKit

struct CalculatorBrain {

    mutating func addUnaryOperation(
        named symbol: String,
        _ operation: @escaping (Double) -> Double
    ) {
        operations[symbol] = Operation.unaryOperation(operation)
    }
    private var accumulator: Double?

    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }

    private var operations: Dictionary<String, Operation> = [
        "𝝿": .constant(Double.pi),
        "e": .constant(M_E),
        "cos": .unaryOperation(cos),
        "√": .unaryOperation(sqrt),
        "+": .binaryOperation({$0 + $1}),
        "−": .binaryOperation({$0 - $1}),
        "×": .binaryOperation({$0 * $1}),
        "÷": .binaryOperation({$0 / $1}),
        "±": .unaryOperation({-$0}),
        "C": .constant(0),
        "=": .equals
    ]

    private var pendingBinaryOperation: PendingBinaryOperation?

    mutating func perforOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value): accumulator = value
            case .unaryOperation(let function):
                if let operand = accumulator {
                    accumulator = function(operand)
                }
            case .binaryOperation(let function):
                if let operand = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(
                        function: function,
                        firstOperand: operand
                    )
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }

    private mutating func performPendingBinaryOperation() {
        if let operand = accumulator {
            accumulator = pendingBinaryOperation?.perform(with: operand)
            pendingBinaryOperation = nil
        }
    }

    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double

        func perform(with secondOperand: Double) -> Double {
            function(firstOperand, secondOperand)
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
