//
//  ViewController.swift
//  Calculator
//
//  Created by Ilya Mudriy on 10.10.2017.
//  Copyright © 2017 Ilya Mudriy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Math {
        case None, Add, Minus, Multiply,Divide
    }
    var numbersOnScreen: Double = 0
    var previousNumber: Double = 0
    var mathSymbol: Math = Math.None
    var isResult: Bool = false
    @IBOutlet weak var outputLabel: UILabel!
    
    // MARK: Clear label button
    @IBAction func clearOutputLabel(_ sender: UIButton) {
        outputLabel.text = "0"
        previousNumber = 0
        numbersOnScreen = 0
        mathSymbol = Math.None
    }
    
    // MARK: Press digit
    @IBAction func pressDigit(_ sender: UIButton) {
        if var text = outputLabel.text {
            if text.hasPrefix("0") && !text.hasPrefix("0,") {
                text.removeFirst()
            }
            if isResult {
                outputLabel.text = String(sender.tag)
                isResult = false
            } else {
                outputLabel.text = text + String(sender.tag)
            }
            numbersOnScreen = Double(outputLabel.text!)!
            print("Numbers on screen - ",numbersOnScreen)
        }
    }
    
    // MARK: Choose calculation
    @IBAction func calculationButtons(_ sender: UIButton) {
        if sender.currentTitle == "+/-" {
            if let res = outputLabel.text {
                let minusResult = -Double(res)!
                outputLabel.text = String(minusResult)
                numbersOnScreen = minusResult
                isResult = true
            }
            previousNumber = Double(outputLabel.text!)!
        }
        else if sender.currentTitle == "%" {
            print("selected %")
            previousNumber = Double(outputLabel.text!)!
        }
        else if sender.currentTitle == "/" {
            print("selected /")
            mathSymbol = Math.Divide
            previousNumber = Double(outputLabel.text!)!
        }
        else if sender.currentTitle == "x" {
            print("selected x")
            mathSymbol = Math.Multiply
            previousNumber = Double(outputLabel.text!)!
        }
        else if sender.currentTitle == "-" {
            print("selected -")
            mathSymbol = Math.Minus
            previousNumber = Double(outputLabel.text!)!
        }
        else if sender.currentTitle == "+" {
            print("selected +")
            mathSymbol = Math.Add
            previousNumber = Double(outputLabel.text!)!
        }
        else {
            print("selected =")
            print("PreviousNumber",previousNumber, "+ NUmberOnscreen", numbersOnScreen)
            let result = makeCalculations(a: previousNumber, b: numbersOnScreen, param:mathSymbol)
            print(result)
            previousNumber = result
            outputLabel.text = String(result)
            mathSymbol = Math.None
        }
        isResult = true
    }
    
    // MARK: Calculations
    func makeCalculations(a: Double, b: Double, param: Math) -> Double {
        switch param {
        case Math.Add:
            return a + b
        case Math.Minus:
            return a - b
        case Math.Multiply:
            return a * b
        case Math.Divide:
            return a / b
        default:
            print("Equal tapped")
            return b
        }
    }
    // MARK: VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

