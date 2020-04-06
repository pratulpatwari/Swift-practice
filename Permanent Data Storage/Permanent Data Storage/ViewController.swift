//
//  ViewController.swift
//  Permanent Data Storage
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // we need to check if the object exists in the memory and then write the text field objects
        let nameObject = UserDefaults.standard.object(forKey: "name")
        if let name = nameObject as? String{
            nameText.text = name
        }
        
        let phoneObject = UserDefaults.standard.object(forKey: "phone")
        if let phone = phoneObject as? String{
            phoneText.text = phone
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitPressed(_ sender: Any) {
        UserDefaults.standard.set(nameText.text, forKey: "name")
        UserDefaults.standard.set(phoneText.text, forKey: "phone")
    }
    
}

