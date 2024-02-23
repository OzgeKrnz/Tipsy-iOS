//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    var buttonText = ""
    var tip = 0.10
    var numberOfPeople = 2
    
    var totalAmount = 0.0
    var finalResult = "0.0"
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // klavyeyi acmak icin
        billTextField.delegate = self
    }

    @IBAction func tipChanged(_ sender: UIButton) {
      
        // klavyeyi kapatmak icin
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        
        sender.isSelected = true
        
        buttonText = String(sender.currentTitle!.dropLast())
        
        tip = Double(buttonText)! / 100
        
    }
    
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != ""{
            totalAmount = Double(bill)!
            
            let result = totalAmount * (tip+1) / Double(numberOfPeople)
            finalResult = String(format: "%0.2f", result)
        }
        self.performSegue(withIdentifier: "goToCalculate", sender: self)

    }
    
  
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%0.0f", sender.value)
        
        numberOfPeople = Int(sender.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCalculate"{
            // get instance
            let destinationVc = segue.destination as! ResultsViewController
            
            destinationVc.result = finalResult
            destinationVc.tip = Int(tip * 100)
            destinationVc.split = numberOfPeople
            
            
        }
    }
    

    
   


}

