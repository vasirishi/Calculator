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
    let calculator = Calculator.instance

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.

        calculator.maxDisplayLength = 11
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
        keyPress(.nine)
    }
    @IBAction func key8_click() {
        keyPress(.eight)
    }
    @IBAction func key7_click() {
        keyPress(.seven)
    }
    @IBAction func key6_click() {
        keyPress(.six)
    }
    @IBAction func key5_click() {
        keyPress(.five)
    }
    @IBAction func key4_click() {
        keyPress(.four)
    }
    @IBAction func key3_click() {
        keyPress(.three)
    }
    @IBAction func key2_click() {
        keyPress(.two)
    }
    @IBAction func key1_click() {
        keyPress(.one)
    }
    @IBAction func key0_click() {
        keyPress(.zero)
    }
    @IBAction func keyDecimal_click() {
        buttonClick()
        calculator.addDecimal()
        updateDisplay()
    }
    @IBAction func keyChangeSign_click() {
        buttonClick()
        calculator.changeSign()
        updateDisplay()
    }
    @IBAction func keyPercent_click() {
        buttonClick()
        calculator.doPercentage()
        updateDisplay()
    }
    @IBAction func keyDivide_click() {
        buttonClick()
        calculator.divide()
        updateDisplay()
    }
    @IBAction func keyMultiply_click() {
        buttonClick()
        calculator.multiply()
        updateDisplay()
    }
    @IBAction func keySubtract_click() {
        buttonClick()
        calculator.subtract()
        updateDisplay()
    }
    @IBAction func keyAdd_click() {
        buttonClick()
        calculator.add()
        updateDisplay()
    }
    @IBAction func keyEquals_click() {
        buttonClick()
        calculator.doEquals()
        updateDisplay()
    }

    func keyPress(_ key: Keys) {
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
