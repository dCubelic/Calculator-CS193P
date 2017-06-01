//
//  ViewController.swift
//  Calculator
//
//  Created by Dominik Cubelic on 30/05/2017.
//  Copyright © 2017 Dominik Cubelic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var userIsInTheMiddleOfDecimalNumber = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func touchDecimal(_ sender: UIButton) {
        if(!userIsInTheMiddleOfDecimalNumber) {
            if(!userIsInTheMiddleOfTyping) {
                display.text = "0."
            } else {
                let textCurentlyInDisplay = display.text!
                display.text = textCurentlyInDisplay + "."
            }
            userIsInTheMiddleOfDecimalNumber = true
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text = "0"
        brain.setOperand(operand: 0)
        userIsInTheMiddleOfTyping = false
        userIsInTheMiddleOfDecimalNumber = false
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
            userIsInTheMiddleOfDecimalNumber = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
}

