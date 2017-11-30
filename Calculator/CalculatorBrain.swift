//
//  CalculatorBrain.swift
//  StandforCalculator
//
//  Created by Curtis Wiseman on 8/8/17.
//  Copyright © 2017 Curtis Wiseman. All rights reserved.
//

import Foundation

func changeSigne(sign :Double)->Double {
    return -sign
}

func multiply(a1:Double,a2:Double)->Double{
    return a1*a2
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) ->Double
        let firstOperand: Double
        
        func perform(with secondOPerand: Double) ->Double{
            return function(firstOperand,secondOPerand)
        }
    }
    
    mutating private func performPendingBinaryOperation(){
        if (pendingBinaryOperation != nil && accumulator != nil){
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        //pbo?.perform(with: accumulator!) this does the samething
    }
    
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
   
  //Dictionary to look up a key/value table
  private var operations: Dictionary<String,Operations> = [
        "∏": Operations.constant(Double.pi),
        "e": Operations.constant(M_E),
        "√": Operations.unaryOPerations(sqrt),
        "cos": Operations.unaryOPerations(cos),
        "±":Operations.unaryOPerations(changeSigne),
        "x":Operations.binaryOperations({$0 * $1}),
        "+":Operations.binaryOperations({$0 + $1}),
        "-":Operations.binaryOperations({$0 - $1}),
        "÷":Operations.binaryOperations({$0 / $1}),
        "=":Operations.Equals
    ]
    
    //perform the operations based on the value from the Dictionary 
    mutating func performOperation( _ symbol: String){
        
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOPerations(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperations(let function):
                if accumulator != nil{
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                accumulator = nil
                }
            case .Equals:
                performPendingBinaryOperation()
            }
        }
        
        
    }
  
    
    
    private enum Operations {
        case constant(Double)
        case unaryOPerations((Double)->Double)
        case binaryOperations((Double,Double)->Double)
        case Equals
    }
    
}
