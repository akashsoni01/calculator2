//
//  ViewController.swift
//  calculator
//
//  Created by rdec 3 on 25/11/17.
//  Copyright © 2017 rdec 3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var brain = CalculatorBrain()
    var userIsInTheMiddleOfTyping=false
    @IBOutlet weak var _display: UILabel!
    var display:Double{
        get{
            return Double(_display.text!)!
        }
        set{
            _display.text=String(newValue)
        }
    }
    @IBAction func dotButtonTuch(_ sender: UIButton) {
        if !_display.text!.characters.contains("."){
            _display.text = _display.text! + "."
        }
    }
    //make a function that dose't allow more zero at zero value
    // if Double(display)==0{display = 0}
    func stopeMessZeros(_ sender:UIButton){
        if display==0.0{
            _display.text = 0
            userIsInTheMiddleOfTyping = false
        }
    }
    
    @IBAction func tuchOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(display)
            userIsInTheMiddleOfTyping=false
        }
        if let mathmaticalSymbol = sender.currentTitle{
            brain.performOperator(mathmaticalSymbol)
        }
        if let result=brain.result{
            display=result
        }
        
    }
    @IBAction func digit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsInTheMiddleOfTyping){
            _display.text = _display.text! + digit
        }
        else{
            _display.text = sender.currentTitle!
            userIsInTheMiddleOfTyping = true
        }
    }
    
    override func viewDidLoad() {
        brain.addUnaryOperation(named: "✅"){
            //[weak weakSelf = self] in
            self._display.textColor = UIColor.green
            return sqrt($0)
        }
    }
}
