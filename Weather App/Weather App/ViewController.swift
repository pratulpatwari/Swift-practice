//
//  ViewController.swift
//  Weather App
//
//  Created by pratul patwari on 6/1/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func submitButtonPressed(_ sender: Any) {
        
        let domain = "https://www.weather-forecast.com/locations/"
        let parameter = "/forecasts/latest"
        var finalURL = ""
        
        if let city = textField.text{
            resultLabel.text = city
            if city.contains(" "){
                finalURL = domain + city.replacingOccurrences(of: " ", with: "-") + parameter
                print(finalURL)
            }
            else{
                finalURL = domain + city + parameter
            }
        }
        
        
        
        if let url = URL(string: finalURL){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, respose, error in
                if let error = error{
                    print(error)
                }
                else{
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        print(dataString ?? "No data returned")
                        let stringSeperator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                        if let contentArray = dataString?.components(separatedBy: stringSeperator){
                            if contentArray.count > 0 {
                                print(contentArray)
                            }
                        }
                    }
                }
            }
            task.resume()
            
        }
    }
}

