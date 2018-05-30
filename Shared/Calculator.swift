//
//  Calculator.swift
//  Calculator
//
//  Created by John Florian on 5/18/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import Foundation

public enum Keys: String {
    case clear = ""
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "."
    case negative = "-"
    case percent = "%"
}

private enum Operators: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
}

// Basic math functions
private func doAdd(a: Double, b: Double) -> Double {
    return a + b
}
private func doSubtract(a: Double, b: Double) -> Double {
    return a - b
}
private func doMultiply(a: Double, b: Double) -> Double {
    return a * b
}
private func doDivide(a: Double, b: Double) -> Double {
    return a / b
}
private func doPercent(a: Double, b: Double) -> Double {
    return a / 100 * b
}

public class Calculator: NSObject {
    // Make this a singleton class
    public static let instance = Calculator()
    private override init() {
        super.init()
    }

    typealias BinaryOperator = (Double, Double) -> Double
    private let operators: [Operators: BinaryOperator] = [ .add: doAdd, .subtract: doSubtract, .multiply: doMultiply, .divide: doDivide]

    // Mark - Private Global Properties

    private var userInput = "0" // User-entered digits
    private var accumulator: Double? = 0.0 // Store the calculated value here
    private var numberStack: [Double] = [] // Collection of entered numbers between operations
    private var operatorStack: [Operators] = [] // Collection of operators between entered numbers

    // Mark - Public Properties

    public var maxDisplayLength = 11

    public var displayText: String {
        get {
            var myString = "ERROR"

            guard accumulator != nil && abs(accumulator!) <= Double.greatestFiniteMagnitude else {
                clearAll()

                return myString
            }

            // If the value is an integer, don't show a decimal point
            if accumulator! > Double(Int64.max) {

            }
            else {
                let accumulatorInteger = Int64(accumulator!)
                if accumulator! - Double(accumulatorInteger) == 0 {
                    myString = "\(accumulatorInteger)"
                }
                else {
                    myString = "\(accumulator!)"
                }
            }

            // add negative and/or decimal when zero
            if userInput.contains(".") && !myString.contains(".") {
                myString += "."
            }

            if userInput.contains("-") && !myString.contains("-") {
                myString = "-" + myString
            }

            // do we need to shorten the display?
            if myString.count > maxDisplayLength {
                myString = "\(myString.scientificFormatted)"
            }

            return myString
        }
    }

    // Mark - Public Methods

    public func clear() {
        keyPress(.clear)
    }

    public func clearAll() {
        userInput = "0"
        accumulator = Double(userInput)
        numberStack.removeAll()
        operatorStack.removeAll()
    }

    public func changeSign() {
        keyPress(.negative)
    }

    public func addDecimal() {
        keyPress(.decimal)
    }

    public func doPercentage() {
        keyPress(.percent)
//        doMath(.percent)
    }

    public func add() {
        doMath(.add)
    }

    public func subtract() {
        doMath(.subtract)
    }

    public func multiply() {
        doMath(.multiply)
    }

    public func divide() {
        doMath(.divide)
    }

    public func keyPress(_ key: Keys) {
        guard key != .decimal || (key == .decimal && !userInput.contains(key.rawValue)) else { return }

        userInput = handleInput(input: key, userInput: userInput)
        accumulator = Double(userInput)
        if accumulator == nil {
            userInput = "0"
            accumulator = Double(userInput)
        }
    }

    // Mark - Private Methods

    private func handleInput(input: Keys, userInput: String) -> String {
        var currentInput = !userInput.isEmpty ? userInput : "0"

        switch input {
        case .clear: // clear last digit
            currentInput.removeLast()
            break
        case .negative: // change sign
            if currentInput == "0" { currentInput = displayText }
            if currentInput.hasPrefix(input.rawValue) {
                // Remove the existing negative sign
                currentInput = String(currentInput[currentInput.index(after: currentInput.startIndex)..<currentInput.endIndex])
            }
            else {
                currentInput = input.rawValue + currentInput
            }
            break
        case .percent: // convert last number entered to percentage
            // If the current userInput is just a number, convert it to a percentage; otherwise, multiply that percentage with the previous value
            // if adding or subtracting, do operation first, then get percentage of result
            // if multiplying or dividing, get current number as a percentage of itself, then perform math against previous number

            let multiplier = [.multiply, .divide].contains(operatorStack.last) ? 1.0 : numberStack.last ?? 1.0
            currentInput = String(doPercent(a: Double(currentInput)!, b: multiplier))
            break
        default: // append the keystroke to the current entry string
            currentInput += input.rawValue
            break
        }

        return !currentInput.isEmpty ? currentInput : "0"
    }

    private func doMath(_ newOperator: Operators) {
        guard accumulator != nil else { return }

        let activeOperators: [Operators] = [.add, .subtract]
        let passiveOperators: [Operators] = [.multiply, .divide]

        if !userInput.isEmpty && !numberStack.isEmpty {
            if let stackOperator = operatorStack.last {
                if !(activeOperators.contains(stackOperator) && passiveOperators.contains(newOperator)) {
                    if let operation = operators[operatorStack.removeLast()] {
                        accumulator = operation(numberStack.removeLast(), accumulator!)
                        doEquals()
                    }
                }
            }
        }
        operatorStack.append(newOperator)
        numberStack.append(accumulator!)
        userInput = ""
    }

    public func doEquals() {
        if !numberStack.isEmpty && !operatorStack.isEmpty {
            if let lastOperator = operators[operatorStack.removeLast()] {
                accumulator = lastOperator(numberStack.removeLast(), accumulator!)
            }
            if !operatorStack.isEmpty {
                doEquals()
            }
        }
        userInput = ""
    }
}
