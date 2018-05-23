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
    let calculator = Calculator.instance

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

        calculator.clearAll()
        updateDisplay()
    }
    @IBAction func clearButton_click() {
        buttonClick()
        calculator.clear()
        updateDisplay()
    }
    @IBAction func key9_click() {
        keyPress("9")
    }
    @IBAction func key8_click() {
        keyPress("8")
    }
    @IBAction func key7_click() {
        keyPress("7")
    }
    @IBAction func key6_click() {
        keyPress("6")
    }
    @IBAction func key5_click() {
        keyPress("5")
    }
    @IBAction func key4_click() {
        keyPress("4")
    }
    @IBAction func key3_click() {
        keyPress("3")
    }
    @IBAction func key2_click() {
        keyPress("2")
    }
    @IBAction func key1_click() {
        keyPress("1")
    }
    @IBAction func key0_click() {
        keyPress("0")
    }
    @IBAction func keyDecimal_click() {
        keyPress(".")
    }
    @IBAction func keyChangeSign_click() {
        keyPress("-")
    }
    @IBAction func keyPercent_click() {
        keyPress("%")
    }
    @IBAction func keyDivide_click() {
        buttonClick()
        calculator.doMath("/")
        updateDisplay()
    }
    @IBAction func keyMultiply_click() {
        buttonClick()
        calculator.doMath("*")
        updateDisplay()
    }
    @IBAction func keySubtract_click() {
        buttonClick()
        calculator.doMath("-")
        updateDisplay()
    }
    @IBAction func keyAdd_click() {
        buttonClick()
        calculator.doMath("+")
        updateDisplay()
    }
    @IBAction func keyEquals_click() {
        buttonClick()
        calculator.doEquals()
        updateDisplay()
    }

    func keyPress(_ key: String) {
        buttonClick()
        calculator.keyPress(key)
        updateDisplay()
    }

    func buttonClick() {
        WKInterfaceDevice.current().play(.click)
    }

    func updateDisplay() {
        displayLabel.setText(calculator.displayText)
    }

}
