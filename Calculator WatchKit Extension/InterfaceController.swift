//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by John Florian on 12/22/16.
//  Copyright © 2016 John Florian. All rights reserved.
//

import WatchKit
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

class InterfaceController: WKInterfaceController {
    var displayLabelText = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
        clearButton_click()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    @IBAction func clearButton_longPress(_ sender: Any) {
        WKInterfaceDevice.current().play(.retry)
        
        userInput = "0"
        accumulator = 0
        updateDisplay()
        numberStack.removeAll()
        operatorStack.removeAll()
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBOutlet var displayLabel: WKInterfaceLabel!
    @IBOutlet var clearButton: WKInterfaceButton!

    func buttonClick() {
        WKInterfaceDevice.current().play(.click)
    }

    @IBAction func clearButton_click() {
        buttonClick()
        handleInput("")
    }
    @IBAction func key9_click() {
        buttonClick()
        handleInput("9")
    }
    @IBAction func key8_click() {
        buttonClick()
        handleInput("8")
    }
    @IBAction func key7_click() {
        buttonClick()
        handleInput("7")
    }
    @IBAction func key6_click() {
        buttonClick()
        handleInput("6")
    }
    @IBAction func key5_click() {
        buttonClick()
        handleInput("5")
    }
    @IBAction func key4_click() {
        buttonClick()
        handleInput("4")
    }
    @IBAction func key3_click() {
        buttonClick()
        handleInput("3")
    }
    @IBAction func key2_click() {
        buttonClick()
        handleInput("2")
    }
    @IBAction func key1_click() {
        buttonClick()
        handleInput("1")
    }
    @IBAction func key0_click() {
        buttonClick()
        handleInput("0")
    }
    @IBAction func keyDivide_click() {
        buttonClick()
        doMath("/")
    }
    @IBAction func keyMultiply_click() {
        buttonClick()
        doMath("*")
    }
    @IBAction func keySubtract_click() {
        buttonClick()
        doMath("-")
    }
    @IBAction func keyAdd_click() {
        buttonClick()
        doMath("+")
    }
    @IBAction func keyEquals_click() {
        buttonClick()
        doEquals()
    }
    @IBAction func keyDecimal_click() {
        buttonClick()
        if !userInput.contains("."){
            handleInput(".")
        }
    }
    @IBAction func keyChangeSign_click() {
        buttonClick()
        if userInput.isEmpty {
            userInput = displayLabelText
        }
        handleInput("-")
    }
    @IBAction func keyPercent_click() {
        buttonClick()
        if userInput.isEmpty {
            userInput = displayLabelText
        }
        handleInput("%")
    }

    @IBOutlet var key9: WKInterfaceButton!
    @IBOutlet var key8: WKInterfaceButton!
    @IBOutlet var key7: WKInterfaceButton!
    @IBOutlet var key6: WKInterfaceButton!
    @IBOutlet var key5: WKInterfaceButton!
    @IBOutlet var key4: WKInterfaceButton!
    @IBOutlet var key3: WKInterfaceButton!
    @IBOutlet var key2: WKInterfaceButton!
    @IBOutlet var key1: WKInterfaceButton!
    @IBOutlet var keyDivide: WKInterfaceButton!
    @IBOutlet var keyMultiply: WKInterfaceButton!
    @IBOutlet var keySubtract: WKInterfaceButton!
    @IBOutlet var keyAdd: WKInterfaceButton!
    @IBOutlet var keyEquals: WKInterfaceButton!
    @IBOutlet var keyDecimal: WKInterfaceButton!
    @IBOutlet var keyChangeSign: WKInterfaceButton!
    @IBOutlet var keyPercent: WKInterfaceButton!

    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "0" // User-entered digits

    var numberStack: [Double] = [] // Number stack
    var operatorStack: [String] = [] // Operator stack

    func handleInput(_ string: String) {
        switch string {
        case "":
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
        case "-":
            if userInput.hasPrefix(string) {
                // Strip off the first character (a dash)
                userInput = userInput.substring(from: userInput.index(after: userInput.startIndex))
            }
            else {
                userInput = string + userInput
            }

            break
        default:
            userInput += string

            break
        }

        accumulator = Double(userInput)!
        updateDisplay()
    }

    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let accumulatorInteger = Int64(accumulator)
        if accumulator - Double(accumulatorInteger) == 0 {
            displayLabelText = "\(accumulatorInteger)"
            if displayLabelText.count > 13 {
                displayLabelText = "\(accumulatorInteger.scientificFormatted)"
            }
        }
        else {
            displayLabelText = "\(accumulator)"
            if displayLabelText.count > 13 {
                displayLabelText = "\(accumulator.scientificFormatted)"
            }
        }

        displayLabel.setText(displayLabelText)
    }

    func doMath(_ newOperator: String) {
        if !userInput.isEmpty && !numberStack.isEmpty {
            let stackOperator = operatorStack.last
            if !((stackOperator == "+" || stackOperator == "-") && (newOperator == "*" || newOperator == "/")) {
                let lastOperator = operators[operatorStack.removeLast()]
                accumulator = lastOperator!(numberStack.removeLast(), accumulator)
                doEquals()
            }
        }
        operatorStack.append(newOperator)
        numberStack.append(accumulator)
        userInput = "0"
        updateDisplay()
    }

    func doEquals() {
        if userInput.isEmpty {
            return
        }
        if !numberStack.isEmpty {
            let lastOperator = operators[operatorStack.removeLast()]
            accumulator = lastOperator!(numberStack.removeLast(), accumulator)
            if !operatorStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = "0"
    }
}
