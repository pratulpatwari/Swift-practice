//
//  ViewController.swift
//  Controlling The Keyboard
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this will close the text pad once we touch on the screen anywhere.
    // this touch will not be specifically associated with any field on the page
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // this will close the touch pad associated with a perticular field on the page
    // in order to use this, we need to extend one class called UITextFieldDelegate
    // and drag and delegate the text field to ViewController
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

