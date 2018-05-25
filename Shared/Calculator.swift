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
private func doAdd(_ a: Double, b: Double) -> Double {
    return a + b
}
private func doSubtract(_ a: Double, b: Double) -> Double {
    return a - b
}
private func doMultiply(_ a: Double, b: Double) -> Double {
    return a * b
}
private func doDivide(_ a: Double, b: Double) -> Double {
    return a / b
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
    private var numberStack: [Double] = []
    private var operatorStack: [Operators] = []

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
                    if myString.count > maxDisplayLength {
                        myString = "\(accumulatorInteger.scientificFormatted)"
                    }
                }
                else {
                    myString = "\(accumulator!)"
                    if myString.count > maxDisplayLength {
                        myString = "\(accumulator!.scientificFormatted)"
                    }
                }
            }

            // add negative and/or decimal when zero
            if myString == "0" {
                if userInput.contains(".") {
                    myString += "."
                }

                if userInput.contains("-") {
                    myString = "-" + myString
                }
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
        let myString = !userInput.isEmpty ? userInput : "0"

        guard key != .decimal || (key == .decimal && !myString.contains(key.rawValue)) else { return }

        userInput = handleInput(input: key, userInput: myString)
        accumulator = Double(userInput)
        if accumulator == nil {
            userInput = "0"
            accumulator = Double(userInput)
        }
    }

    // Mark - Private Methods

    private func handleInput(input: Keys, userInput: String) -> String {
        var myString = !userInput.isEmpty ? userInput : "0"

        switch input {
        case .clear: // clear last digit
            myString.removeLast()
            break
        case .negative: // change sign
            if myString == "0" { myString = displayText }
            if myString.hasPrefix(input.rawValue) {
                // Remove the existing negative sign
                myString = String(myString[myString.index(after: myString.startIndex)..<myString.endIndex])
            }
            else {
                myString = input.rawValue + myString
            }
            break
        case .percent: // convert last number entered to percentage
            // If the current userInput is just a number, convert it to a percentage; otherwise, multiply that percentage with the previous value
            // if adding or multiplying, do as is
            // if multiplying or dividing, get current number as a percentage of itself, then perform math against previous number
            if Double(myString) == 0.0 {
                myString = "0"
            }
            else {
                let number: Double? = numberStack.count > 0 ? numberStack.last : 1.0
                myString = String(doMultiply(doDivide(Double(myString)!, b: 100), b: number!))
            }
            break
        default: // append the keystroke to the current entry string
            myString += input.rawValue
            break
        }

        return !myString.isEmpty ? myString : "0"
    }

    private func doMath(_ newOperator: Operators) {
        if !userInput.isEmpty && !numberStack.isEmpty {
            let stackOperator = operatorStack.last
            if !((stackOperator == .add || stackOperator == .subtract) && (newOperator == .multiply || newOperator == .divide)) {
                let lastOperator = operators[operatorStack.removeLast()]
                accumulator = lastOperator!(numberStack.removeLast(), accumulator!)
                doEquals()
            }
        }
        operatorStack.append(newOperator)
        numberStack.append(accumulator!)
        userInput = "0"
    }

    public func doEquals() {
        if userInput.isEmpty {
            return
        }
        if !numberStack.isEmpty {
            let lastOperator = operators[operatorStack.removeLast()]
            accumulator = lastOperator!(numberStack.removeLast(), accumulator!)
            if !operatorStack.isEmpty {
                doEquals()
            }
        }
        userInput = "0"
    }
}
