//
//  Calculator.swift
//  Calculator
//
//  Created by John Florian on 5/18/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import Foundation

// Basic math functions
private func add(_ a: Double, b: Double) -> Double {
    return a + b
}
private func subtract(_ a: Double, b: Double) -> Double {
    return a - b
}
private func multiply(_ a: Double, b: Double) -> Double {
    return a * b
}
private func divide(_ a: Double, b: Double) -> Double {
    return a / b
}

public class Calculator: NSObject {
    public static let instance = Calculator()

    private override init() {
        super.init()
    }

    typealias Binop = (Double, Double) -> Double
    private let operators: [String: Binop] = [ "+" : add, "-" : subtract, "*" : multiply, "/" : divide ]

    public private(set) var accumulator: Double? = 0.0 // Store the calculated value here
    private var userInput = "0" // User-entered digits

    private var numberStack: [Double] = [] // Number stack
    private var operatorStack: [String] = [] // Operator stack

    public var displayText: String {
        get {
            var myString = "ERROR"
//             accumulator = Double(userInput)

            //        guard accumulator != nil else { return }
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
                    if myString.count > 11 {
                        myString = "\(accumulatorInteger.scientificFormatted)"
                    }
                }
                else {
                    myString = "\(accumulator!)"
                    if myString.count > 11 {
                        myString = "\(accumulator!.scientificFormatted)"
                    }
                }
            }

            return myString // displayLabelText
        }
    }

    public func clear() {
        userInput = handleInput(input: "", userInput: userInput)
        accumulator = Double(userInput)
    }

    public func clearAll() {
        userInput = "0"
        accumulator = Double(userInput)
        numberStack.removeAll()
        operatorStack.removeAll()
    }

    public func keyPress(_ key: String) {
        let myString = !userInput.isEmpty ? userInput : "0"

        guard key != "." || (key == "." && !myString.contains(key)) else { return }
        guard ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "%", "."].contains(key) else { return }

        userInput = handleInput(input: key, userInput: myString)
        accumulator = Double(userInput)
    }

    private func handleInput(input: String, userInput: String) -> String {
        var myString = !userInput.isEmpty ? userInput : "0"

        switch input {
        case "": // clear last digit
            myString.removeLast()
            break
        case "-": // change sign
            if myString.hasPrefix(input) {
                // Strip off the first character (a dash)
                myString = String(myString[myString.index(after: myString.startIndex)...myString.endIndex])
            }
            else {
                myString = myString == "0" ? myString : input + myString
            }
            break
        case "%": // convert last number entered to percentage
            if Double(myString) == 0.0 {
                myString = "0"
            }
            else {
                let number: Double? = numberStack.count > 0 ? numberStack.last : 1.0
                myString = String(multiply(divide(Double(myString)!, b: 100), b: number!))
            }
            break
        default: // append the keystroke to the current entry string
            myString += input
            break
        }

        return !myString.isEmpty ? myString : "0"
    }

    public func doMath(_ newOperator: String) {
        if !userInput.isEmpty && !numberStack.isEmpty {
            let stackOperator = operatorStack.last
            if !((stackOperator == "+" || stackOperator == "-") && (newOperator == "*" || newOperator == "/")) {
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
