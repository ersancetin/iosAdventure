//
//  ViewController.swift
//  Calculator
//
//  Created by Ersan Çetin on 17.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var integerOne: UITextField!
    
    @IBOutlet weak var integerTwo: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func toplaClicked(_ sender: Any) {
        let firstNumber = Int(integerOne.text ?? "" ) ?? 0
        let secondNumber = Int(integerTwo.text ?? "" ) ?? 0
        
        let result = firstNumber + secondNumber
        
        resultLabel.text = String(result)
        
//        if let firstNumber = Int(integerOne.text!) {
//            if let secondNumber = Int(integerTwo.text!){
//
//                let result = firstNumber + secondNumber
//
//                resultLabel.text = String(result)
//            }
//        }
        
    }
    
    @IBAction func cikarClicked(_ sender: Any) {
        let firstNumber = Int(integerOne.text ?? "" ) ?? 0
        let secondNumber = Int(integerTwo.text ?? "" ) ?? 0
        
        let result = firstNumber - secondNumber
        
        resultLabel.text = String(result)
        
    }
    
    @IBAction func carpClicked(_ sender: Any) {
        let firstNumber = Int(integerOne.text ?? "" ) ?? 0
        let secondNumber = Int(integerTwo.text ?? "" ) ?? 0
        
        let result = firstNumber * secondNumber
        
        resultLabel.text = String(result)
        
    }
    
    @IBAction func bolClicked(_ sender: Any) {
        let firstNumber = Int(integerOne.text ?? "" ) ?? 0
        let secondNumber = Int(integerTwo.text ?? "" ) ?? 0
        
        let result = firstNumber / secondNumber
        
        resultLabel.text = String(result)
        
    }
    
    
}

