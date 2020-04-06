//
//  ViewController.swift
//  Local Host
//
//  Created by pratul patwari on 6/1/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fromInput: UITextField!
    
    @IBOutlet weak var toInput: UITextField!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: Any) {
        
        var from = ""
        if let fromCurrency = fromInput.text {
            from = fromCurrency
        }
        
        var to = ""
        if let toCurrency = toInput.text {
            to = toCurrency
        }
        
        var amountToBeConverted: Double
        if let amountValue = amount.text {
            if let amountNumber = Double(amountValue){
                amountToBeConverted = amountNumber
            }
            else{
                amountToBeConverted = 1.0
            }
        }
        else {
            amountToBeConverted = 1.0
        }
        
        let baseUrl = "http://pratuls-MacBook-Air.local:8090/getCurrency?"
        
        let finalUrl = baseUrl + "from=" + from + "&to=" + to
        
        if let url = URL(string: finalUrl){
            
            let request = NSMutableURLRequest(url: url) // create request from the url
            
            // create a URL session task which will get to the web, grab the content and and return
            // this session is like opening a browser to get the website content

                let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if let error = error{
                    print(error)
                }
                else{
                    /*if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        print(dataString ?? "No data returned")
                        // if we have to display this data in a label, then we have to use Dipatch
                        // if we don't use this, then the load of data will happen after the content is loaded
                        // It will be synchronous which will be very slow as it will wait for the task to finish
                        
                        
                        // this will load the data straight away
                        DispatchQueue.main.sync(execute: {
                            self.result.text = dataString! as String
                        })
                    }*/
                    
                    // receiving the Json data
                    
                    if let urlContent = data {
                        // since the Json serialization can be bad, we want to handle the error gracefully
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                            print(jsonResult)
                            
                            if let exchange = jsonResult as? [String:String]{
                                var exchangeRateRateValue = ""
                                if let exchangeRate = exchange["exchangeRate"] {
                                    exchangeRateRateValue = exchangeRate
                                }
                                
                                var rate: Double
                                if let rateValue = Double(exchangeRateRateValue){
                                    rate = rateValue
                                }
                                else {
                                    rate = 1.0
                                }
                                
                                DispatchQueue.main.sync(execute: {
                                    self.result.text = String(rate * amountToBeConverted) + " " + exchange["toCurrencyName"]!
                                })
                            }
                            
                        }
                        catch {
                            print("JSON processing failed")
                        }
                    }
                }
            }
          
             task.resume()
    }
    
}
}
