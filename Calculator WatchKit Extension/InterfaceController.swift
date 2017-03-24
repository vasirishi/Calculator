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
    let result = a + b
    return result
}
func subtract(_ a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func multiply(_ a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func divide(_ a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : subtract, "*" : multiply, "/" : divide ]

class InterfaceController: WKInterfaceController {
    var displayLabelText = ""
    var displayLabelValue = 0.0
    var leftPartInt = 0
    var rightPartInt = 0

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
        numStack.removeAll()
        opStack.removeAll()
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
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(".")
        }
    }
    @IBAction func keyChangeSign_click() {
        if userInput.isEmpty {
            userInput = displayLabel.value(forKey: "") as! String
        }
        handleInput("-")
    }
    @IBAction func keyPercent_click() {
        doPercent()
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

    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack

    // Looks for a single character in a string.
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str.characters {
            if c == chr {
                return true
            }
        }
        return false
    }

    func handleInput(_ str: String) {
        if str == "-" {
            if userInput.hasPrefix(str) {
                // Strip off the first character (a dash)
                userInput = userInput.substring(from: userInput.characters.index(after: userInput.startIndex))
            } else {
                userInput = str + userInput
            }
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
    }

    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            displayLabel.setText ("\(iAcc)")
        } else {
            displayLabel.setText ("\(accumulator)")
        }
    }

    func doPercent(){
        if userInput == "" {
            return
        }
        userInput = String(add(divide(Double(userInput)!, b: 100), b: 1))
        updateDisplay()
    }

    func doMath(_ newOp: String) {
        if userInput != "" && !numStack.isEmpty {
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                doEquals()
            }
        }
        opStack.append(newOp)
        numStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }

    func doEquals() {
        if userInput == "" {
            return
        }
        if !numStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }
}
