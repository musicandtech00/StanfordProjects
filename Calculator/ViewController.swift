//
//  ViewController.swift
//  StandforCalculator
//
//  Created by Curtis Wiseman on 8/7/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var userIsInTheMiddleOfTyping = false
    private let decimal = "."

    var thisIsaChange = 0
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
       
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if digit != decimal || display.text!.range(of: decimal) == nil {
                display.text = textCurrentlyInDisplay + digit
                print("enter into this loop")
            }
        } else {
            if digit == decimal {
                display.text = "0\(digit)"
            } else {
                display.text = digit
            }
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

