//
//  Calculator.swift
//  Calculator
//
//  Created by John Florian on 5/18/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import Foundation

// Basic math functions
func add(_ a: Double, b: Double) -> Double {
    return a + b
}
func subtract(_ a: Double, b: Double) -> Double {
    return a - b
}
func multiply(_ a: Double, b: Double) -> Double {
    return a * b
}
func divide(_ a: Double, b: Double) -> Double {
    return a / b
}

typealias Binop = (Double, Double) -> Double
let operators: [String: Binop] = [ "+" : add, "-" : subtract, "*" : multiply, "/" : divide ]

var displayLabelText = ""
var accumulator: Double? = 0.0 // Store the calculated value here
var userInput = "0" // User-entered digits

var numberStack: [Double] = [] // Number stack
var operatorStack: [String] = [] // Operator stack

func handleInput(_ string: String, displayLabelText: String) -> Double? {
    switch string {
    case "": // clear last digit
        if !userInput.isEmpty {
            userInput.removeLast()
        }

        if userInput.isEmpty {
            userInput = "0"
        }

        break
    case "%":
        if userInput.isEmpty {
            // do cool stuff with current display
            userInput = displayLabelText
        }

        if !userInput.isEmpty {
            if Double(userInput) == 0.0 {
                userInput = "0"
            }
            else {
                let number = numberStack.count != 0 ? numberStack.last : 1.0
                userInput = String(multiply(divide(Double(userInput)!, b: 100), b: number!))
            }
        }

        break
    case "-": // change sign
        if userInput.hasPrefix(string) {
            // Strip off the first character (a dash)
            userInput = String(userInput[userInput.index(after: userInput.startIndex)...userInput.endIndex])
        }
        else {
            userInput = string + userInput
        }

        break
    default:
        userInput += string

        break
    }

//    accumulator =  Double(userInput) != nil ? Double(userInput)! : 0
    return Double(userInput)
}

func doMath(_ newOperator: String) {
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

func doEquals() {
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

