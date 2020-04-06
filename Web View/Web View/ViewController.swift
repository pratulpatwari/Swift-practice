//
//  ViewController.swift
//  Web View
//
//  Created by pratul patwari on 6/1/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    
    @IBOutlet weak var webkitView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://mirusmed.com/")
        let request = URLRequest(url: url!)
        
        webkitView.load(request)
        
       /* if let url = URL(string: "https://mirusmed.com/"){
        
            let request = NSMutableURLRequest(url: url) // create request from the url
            
            // create a URL session task which will get to the web, grab the content and and return
            // this session is like opening a browser to get the website content
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if let error = error{
                    print(error)
                }
                else{
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        print(dataString ?? "No data returned")
                        // if we have to display this data in a label, then we have to use Dipatch
                        // if we don't use this, then the load of data will happen after the content is loaded
                        // It will be synchronous which will be very slow as it will wait for the task to finish
                        
                        // this will load the data straight away
                        DispatchQueue.main.sync(execute: {
                            // Update UI
                        })
                    }
                }
            }
            
            task.resume() // this is multithreading, this is multithreaded programming
                            // any code below this will be executed before this error or data print
            // this is a queue
 
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



