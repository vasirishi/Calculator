//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by John Florian on 12/22/16.
//  Copyright © 2016 John Florian. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    //    var displayLabelText = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
        clearButton_longPress("")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBOutlet var displayLabel: WKInterfaceLabel!
    @IBOutlet var clearButton: WKInterfaceButton!
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

    @IBAction func clearButton_longPress(_ sender: Any) {
        WKInterfaceDevice.current().play(.retry)

        userInput = "0"
        accumulator = 0
        updateDisplay()
        numberStack.removeAll()
        operatorStack.removeAll()
    }
    @IBAction func clearButton_click() {
        buttonClick()
        accumulator = handleInput("", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key9_click() {
        buttonClick()
        accumulator = handleInput("9", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key8_click() {
        buttonClick()
        accumulator = handleInput("8", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key7_click() {
        buttonClick()
        accumulator = handleInput("7", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key6_click() {
        buttonClick()
        accumulator = handleInput("6", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key5_click() {
        buttonClick()
        accumulator = handleInput("5", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key4_click() {
        buttonClick()
        accumulator = handleInput("4", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key3_click() {
        buttonClick()
        accumulator = handleInput("3", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key2_click() {
        buttonClick()
        accumulator = handleInput("2", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key1_click() {
        buttonClick()
        accumulator = handleInput("1", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func key0_click() {
        buttonClick()
        accumulator = handleInput("0", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func keyDivide_click() {
        buttonClick()
        doMath("/")
        updateDisplay()
    }
    @IBAction func keyMultiply_click() {
        buttonClick()
        doMath("*")
        updateDisplay()
    }
    @IBAction func keySubtract_click() {
        buttonClick()
        doMath("-")
        updateDisplay()
    }
    @IBAction func keyAdd_click() {
        buttonClick()
        doMath("+")
        updateDisplay()
    }
    @IBAction func keyEquals_click() {
        buttonClick()
        doEquals()
        updateDisplay()
    }
    @IBAction func keyDecimal_click() {
        buttonClick()
        if !userInput.contains("."){
            accumulator = handleInput(".", displayLabelText: displayLabelText)
            updateDisplay()
        }
    }
    @IBAction func keyChangeSign_click() {
        buttonClick()
        if userInput.isEmpty {
            userInput = displayLabelText
        }
        accumulator = handleInput("-", displayLabelText: displayLabelText)
        updateDisplay()
    }
    @IBAction func keyPercent_click() {
        buttonClick()
        if userInput.isEmpty {
            userInput = displayLabelText
        }
        accumulator = handleInput("%", displayLabelText: displayLabelText)
        updateDisplay()
    }

    func buttonClick() {
        WKInterfaceDevice.current().play(.click)
    }

    func updateDisplay() {
//        guard accumulator != nil else { return }
        guard accumulator != nil && abs(accumulator!) <= Double.greatestFiniteMagnitude else {
            clearButton_longPress("")
            displayLabelText = "ERROR"
            displayLabel.setText(displayLabelText)
            return
        }

        // If the value is an integer, don't show a decimal point
        let accumulatorInteger = Int64(accumulator!)
        if accumulator! - Double(accumulatorInteger) == 0 {
            displayLabelText = "\(accumulatorInteger)"
            if displayLabelText.count > 13 {
                displayLabelText = "\(accumulatorInteger.scientificFormatted)"
            }
        }
        else {
            displayLabelText = "\(accumulator!)"
            if displayLabelText.count > 13 {
                displayLabelText = "\(accumulator!.scientificFormatted)"
            }
        }

        displayLabel.setText(displayLabelText)
    }

    //// Basic math functions
    //func add(_ a: Double, b: Double) -> Double {
    //    return a + b
    //}
    //func subtract(_ a: Double, b: Double) -> Double {
    //    return a - b
    //}
    //func multiply(_ a: Double, b: Double) -> Double {
    //    return a * b
    //}
    //func divide(_ a: Double, b: Double) -> Double {
    //    return a / b
    //}
    //
    //typealias Binop = (Double, Double) -> Double
    //let operators: [String: Binop] = [ "+" : add, "-" : subtract, "*" : multiply, "/" : divide ]
    //
    //    var accumulator: Double = 0.0 // Store the calculated value here
    //    var userInput = "0" // User-entered digits
    //
    //    var numberStack: [Double] = [] // Number stack
    //    var operatorStack: [String] = [] // Operator stack

    //    func handleInput(_ string: String) {
    //        switch string {
    //        case "":
    //            if !userInput.isEmpty {
    //                userInput.removeLast()
    //            }
    //
    //            if userInput.isEmpty {
    //                userInput = "0"
    //            }
    //
    //            break
    //        case "%":
    //            if userInput.isEmpty {
    //                // do cool stuff with current display
    //                userInput = displayLabelText
    //            }
    //
    //            if !userInput.isEmpty {
    //                if Double(userInput) == 0.0 {
    //                    userInput = "0"
    //                }
    //                else {
    //                    let number = numberStack.count != 0 ? numberStack.last : 1.0
    //                    userInput = String(multiply(divide(Double(userInput)!, b: 100), b: number!))
    //                }
    //            }
    //
    //            break
    //        case "-":
    //            if userInput.hasPrefix(string) {
    //                // Strip off the first character (a dash)
    //                userInput = userInput.substring(from: userInput.index(after: userInput.startIndex))
    //            }
    //            else {
    //                userInput = string + userInput
    //            }
    //
    //            break
    //        default:
    //            userInput += string
    //
    //            break
    //        }
    //
    //        accumulator = Double(userInput)!
    //        updateDisplay()
    //    }
    //
    //    func doMath(_ newOperator: String) {
    //        if !userInput.isEmpty && !numberStack.isEmpty {
    //            let stackOperator = operatorStack.last
    //            if !((stackOperator == "+" || stackOperator == "-") && (newOperator == "*" || newOperator == "/")) {
    //                let lastOperator = operators[operatorStack.removeLast()]
    //                accumulator = lastOperator!(numberStack.removeLast(), accumulator)
    //                doEquals()
    //            }
    //        }
    //        operatorStack.append(newOperator)
    //        numberStack.append(accumulator)
    //        userInput = "0"
    //        updateDisplay()
    //    }
    //
    //    func doEquals() {
    //        if userInput.isEmpty {
    //            return
    //        }
    //        if !numberStack.isEmpty {
    //            let lastOperator = operators[operatorStack.removeLast()]
    //            accumulator = lastOperator!(numberStack.removeLast(), accumulator)
    //            if !operatorStack.isEmpty {
    //                doEquals()
    //            }
    //        }
    //        updateDisplay()
    //        userInput = "0"
    //    }
}
