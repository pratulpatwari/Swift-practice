//
//  ViewController.swift
//  FingerGame
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

    @IBOutlet weak var answer: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func guessButtonClicked(_ sender: Any) {
        
        let fingers = arc4random_uniform(6)
        
        let ans = Int(answer.text!)
        
        if let answerProvided = ans {
            if answerProvided == fingers {
                resultLabel.text = "You are correct"
            }
            else if answerProvided == Int(""){
                resultLabel.text = "You need give me an answer"
            }
            else{
                resultLabel.text = "You are wrong! correct answer is: \(fingers)"
            }
        }
        else{
            resultLabel.text = "You need to put a number"
        }
    }
}

