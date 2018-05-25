//
//  ViewController.swift
//  Calculator
//
//  Created by John Florian on 12/22/16.
//  Copyright © 2016 John Florian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calculator = Calculator.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        calculator.maxDisplayLength = 13
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var key9: UIButton!
    @IBOutlet var key8: UIButton!
    @IBOutlet var key7: UIButton!
    @IBOutlet var key6: UIButton!
    @IBOutlet var key5: UIButton!
    @IBOutlet var key4: UIButton!
    @IBOutlet var key3: UIButton!
    @IBOutlet var key2: UIButton!
    @IBOutlet var key1: UIButton!
    @IBOutlet var key0: UIButton!
    @IBOutlet var keyDivide: UIButton!
    @IBOutlet var keyMultiply: UIButton!
    @IBOutlet var keySubtract: UIButton!
    @IBOutlet var keyAdd: UIButton!
    @IBOutlet var keyEquals: UIButton!
    @IBOutlet var keyDecimal: UIButton!
    @IBOutlet var keyChangeSign: UIButton!
    @IBOutlet var keyPercent: UIButton!

    @IBAction func clearButton_longPress(_ sender: Any) {
//        WKInterfaceDevice.current().play(.retry)

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
//        WKInterfaceDevice.current().play(.click)
    }

    func updateDisplay() {
        displayLabel.text = calculator.displayText
    }


}

