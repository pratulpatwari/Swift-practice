//
//  ViewController.swift
//  Menu Bar
//
//  Created by pratul patwari on 5/30/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet weak var result: UILabel!
    
    var initalValue = 210
    var currentValue = 210
    @objc func processTimer(){
        
        if currentValue > 0{
            currentValue -= 1
            result.text = String(currentValue)
        }
        
        else{
            timer.invalidate()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        result.text = String(initalValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func playButtonPressed(_ sender: Any) {
        // target: means the view controller for which we want to run this timer. In our case it is ViewController so we can write self here
        // Selector will call the function which will tell what action will be berformed in this timer
        // repeat is to ask if you want to repeat
        // timeInterval is in seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        timer.invalidate()
        currentValue = initalValue
        result.text = String(initalValue)
    }
    
    @IBAction func pauseButtonClicked(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func minus10Clicked(_ sender: Any) {
        
        currentValue -= 10
        
        if currentValue >= 0 {
            result.text = String(currentValue)
        }
        else{
            timer.invalidate()
            currentValue += 10
            result.text = String(currentValue)
        }
        
    }
    
    @IBAction func plus10Clicked(_ sender: Any) {
        currentValue += 10
        result.text = String(currentValue)
    }
}

