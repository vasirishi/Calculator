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

    @IBAction func clearButton_click() {
        userInput = ""
        accumulator = 0
        updateDisplay()
        numberStack.removeAll()
        operatorStack.removeAll()
    }
    @IBAction func key9_click() {
        handleInput("9")
    }
    @IBAction func key8_click() {
        handleInput("8")
    }
    @IBAction func key7_click() {
        handleInput("7")
    }
    @IBAction func key6_click() {
        handleInput("6")
    }
    @IBAction func key5_click() {
        handleInput("5")
    }
    @IBAction func key4_click() {
        handleInput("4")
    }
    @IBAction func key3_click() {
        handleInput("3")
    }
    @IBAction func key2_click() {
        handleInput("2")
    }
    @IBAction func key1_click() {
        handleInput("1")
    }
    @IBAction func key0_click() {
        handleInput("0")
    }
    @IBAction func keyDivide_click() {
        doMath("/")
    }
    @IBAction func keyMultiply_click() {
        doMath("*")
    }
    @IBAction func keySubtract_click() {
        doMath("-")
    }
    @IBAction func keyAdd_click() {
        doMath("+")
    }
    @IBAction func keyEquals_click() {
        doEquals()
    }
    @IBAction func keyDecimal_click() {
        if !userInput.contains("."){
            handleInput(".")
        }
    }
    @IBAction func keyChangeSign_click() {
        if userInput.isEmpty {
            userInput = displayLabelText
        }
        handleInput("-")
    }
    @IBAction func keyPercent_click() {
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
    var userInput = "" // User-entered digits

    var numberStack: [Double] = [] // Number stack
    var operatorStack: [String] = [] // Operator stack

    // original version of handleInput function
//    func handleInput(_ str: String) {
//        if str == "-" {
//            if userInput.hasPrefix(str) {
//                // Strip off the first character (a dash)
//                userInput = userInput.substring(from: userInput.characters.index(after: userInput.startIndex))
//            } else {
//                userInput = str + userInput
//            }
//        } else {
//            userInput += str
//        }
//        accumulator = Double((userInput as NSString).doubleValue)
//        updateDisplay()
//    }

    func handleInput(_ str: String) {
        if str == "-" {
            if userInput.hasPrefix(str) {
                // Strip off the first character (a dash)
                userInput = userInput.substring(from: userInput.characters.index(after: userInput.startIndex))
            }
            else {
                userInput = str + userInput
            }
        }
        else if str == "%" {
            if userInput.isEmpty {
                // do cool stuff with current display
                userInput = displayLabelText
            }
            
            if !userInput.isEmpty {
                if Double(userInput) == 0.0 {
                    userInput = ""
                }
                else {
                    let number = numberStack.count != 0 ? numberStack.last : 1.0
                    userInput = String(multiply(divide(Double(userInput)!, b: 100), b: number!))
                }
            }
        }
        else {
            userInput += str
        }
        accumulator = Double(userInput)!
        updateDisplay()
    }

    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            displayLabelText = "\(iAcc)"
            displayLabel.setText(displayLabelText)
        }
        else {
            displayLabelText = "\(accumulator)"
            displayLabel.setText(displayLabelText)
        }
    }

    func doMath(_ newOp: String) {
        if !userInput.isEmpty && !numberStack.isEmpty {
            let stackOp = operatorStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = operators[operatorStack.removeLast()]
                accumulator = oper!(numberStack.removeLast(), accumulator)
                doEquals()
            }
        }
        operatorStack.append(newOp)
        numberStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }

    func doEquals() {
        if userInput.isEmpty {
            return
        }
        if !numberStack.isEmpty {
            let oper = operators[operatorStack.removeLast()]
            accumulator = oper!(numberStack.removeLast(), accumulator)
            if !operatorStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }
}
