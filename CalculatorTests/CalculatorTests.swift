//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by John Florian on 5/22/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import XCTest

class CalculatorTests: XCTestCase {
    var calc: Calculator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calc = Calculator.instance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testAdd() {
        var displayText = ""

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("+")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("+")
        displayText = calc.displayText
        assert(displayText == "4")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "6")
    }

    func testMultiply() {
        var displayText = ""

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("*")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("*")
        displayText = calc.displayText
        assert(displayText == "4")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "8")
    }

    func testSubtract() {
        var displayText = ""

        calc.keyPress("6")
        displayText = calc.displayText
        assert(displayText == "6")

        calc.doMath("-")
        displayText = calc.displayText
        assert(displayText == "6")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("-")
        displayText = calc.displayText
        assert(displayText == "4")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "2")
    }

    func testDivide() {
        var displayText = ""

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.doMath("/")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("/")
        displayText = calc.displayText
        assert(displayText == "4")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "2")
    }

    func testDivideByZero() {
        var displayText = ""

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.doMath("/")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.keyPress("0")
        displayText = calc.displayText
        assert(displayText == "0")

        calc.doMath("/")
        displayText = calc.displayText
        assert(displayText == "ERROR")

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.doMath("/")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.keyPress("0")
        displayText = calc.displayText
        assert(displayText == "0")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "ERROR")

        calc.clear()
        displayText = calc.displayText
        assert(displayText == "0")

    }

    func testEntry() {
        var displayText = ""

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "8")

        calc.addDecimal()
        displayText = calc.displayText
        assert(displayText == "8")

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "8.8")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "8.82")

        calc.clear()
        displayText = calc.displayText
        assert(displayText == "8.8")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "-8.8")

        calc.clear()
        displayText = calc.displayText
        assert(displayText == "-8")

        calc.addDecimal()
        displayText = calc.displayText
        assert(displayText == "-8")

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "-8.8")

        calc.addDecimal()
        displayText = calc.displayText
        assert(displayText == "-8.8")

        calc.keyPress("8")
        displayText = calc.displayText
        assert(displayText == "-8.88")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "8.88")

        calc.clear()
        displayText = calc.displayText
        assert(displayText == "8.8")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "-8.8")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "8.8")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "-8.8")

        calc.changeSign()//calc.keyPress("-")
        displayText = calc.displayText
        assert(displayText == "8.8")

        calc.clearAll()
        displayText = calc.displayText
        assert(displayText == "0")

    }

    func testPercentage() {
        var displayText = ""

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doMath("+")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doPercentage()
        displayText = calc.displayText
        assert(displayText == "0.02")

        calc.doMath("+")
        displayText = calc.displayText
        assert(displayText == "0.02")

        calc.keyPress("2")
        displayText = calc.displayText
        assert(displayText == "2")

        calc.doEquals()
        displayText = calc.displayText
        assert(displayText == "2.02")
    }
}
