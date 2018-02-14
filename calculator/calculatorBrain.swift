//
//  calculatorBrain.swift
//  calculator
//
//  Created by rdec 3 on 25/11/17.
//  Copyright © 2017 rdec 3. All rights reserved.
//

import Foundation

private func fact(_ n:Double) -> Double {
    if n < 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    if n == 0 {
        return 1
    }else{
        
        return fact(n-1) * n
    }
}
struct  CalculatorBrain {
    private var accumlator:Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "log" : Operation.unaryOperation(log),
        "!" : Operation.unaryOperation(fact),
        "±" : Operation.unaryOperation({-$0}),
        "+" : Operation.binaryOperation(+),
        "×" : Operation.binaryOperation(*),
        "-" : Operation.binaryOperation(-),
        "÷" : Operation.binaryOperation(/),
        "%" : Operation.binaryOperation({$0.truncatingRemainder(dividingBy:$1)}),
        "^" : Operation.binaryOperation(pow),
        "=" : Operation.equals
    ]
    
    mutating func addUnaryOperation(named symbol:String,function operation:@escaping ((Double)->Double)){
        operations[symbol] = Operation.unaryOperation(operation)
    }
    mutating func setOperand(_ operand:Double){
        accumlator = operand
    }
    mutating func performOperator(_ symbol:String){
        if let operation=operations[symbol]
        {
            switch  operation{
            case .constant(let value):
                accumlator = value
            case .unaryOperation(let function):
                if accumlator != nil{
                    accumlator = function(accumlator!)
                }
                break
            case .binaryOperation(let fun):
                if accumlator != nil{
                    performpandingBinaryOperation = performPandingBinaryOperation(function:fun,firstOperand:accumlator!)
                    accumlator=nil
                }
                break
            case .equals:
                if performpandingBinaryOperation != nil && accumlator != nil{
                    performPandingBinaryOperationFunc()
                }
                break
            }
        }
        
    }
    private var performpandingBinaryOperation:performPandingBinaryOperation?
    mutating func performPandingBinaryOperationFunc(){
            accumlator = performpandingBinaryOperation?.performWith(secondOperand: accumlator!)
        performpandingBinaryOperation = nil
    }
    private struct performPandingBinaryOperation {
         let function : (Double,Double) -> Double
         let firstOperand:Double
        func performWith(secondOperand x:Double) -> Double {
            return function(firstOperand,x)
        }
    }
    var result : Double? {
        get{
            return accumlator
        }
    }
}
