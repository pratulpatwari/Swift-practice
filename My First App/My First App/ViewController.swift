//
//  ViewController.swift
//  My First App
//
//  Created by pratul patwari on 5/29/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Pratul Patwari")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var labelField: UILabel!
    
    @IBAction func getCatYears(_ sender: Any) {
        
        if let age = ageField.text{
            
            if let ageAsNumber = Int(age){
                
                let ageInCatYears = ageAsNumber * 7
                
                labelField.text = "Your cat is " + String(ageInCatYears) + " in cat years"
            }
            
        }
    }
}

