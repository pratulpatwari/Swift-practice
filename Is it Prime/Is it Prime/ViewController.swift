//
//  ViewController.swift
//  Is it Prime
//
//  Created by pratul patwari on 5/30/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var numberField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func isPrimeCheck(_ sender: Any) {
        
        if let userEnteredString = numberField.text{
            let numberInteger = Int(userEnteredString)
            if let finalNumber = numberInteger{
                
                if finalNumber == 1 {
                    resultLabel.text = "Not a Prime"
                }
                else{
                    var i = 2
                    var isPrime = true
                    while i < finalNumber {
                        if finalNumber % i == 0 {
                            isPrime = false
                        }
                        i += 1
                    }
                    
                    if isPrime {
                        resultLabel.text = "It is Prime"
                    }
                    else{
                        resultLabel.text = "Not a Prime"
                    }
                }
            }
            else{
                resultLabel.text = "You need to put a whole number"
            }
        }
        
        else {
            resultLabel.text = "You need to put a value"
        }
    }
}

