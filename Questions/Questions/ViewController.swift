//
//  ViewController.swift
//  Questions
//
//  Created by pratul patwari on 6/2/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

struct QuestionsGroup : Decodable {
    let question: String
    let options: [Options]
}

struct Options : Decodable{
    let key: String
    let option: String
}

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        serviceCall()
    }
    
    private func serviceCall(){
        let baseUrl = "http://pratuls-macbook-air.local:8090/getQuestions"
        
        if let url = URL(string: baseUrl){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                guard let data = data else {return}
                if let error = error {
                    print(error)
                }
                else {
                    
                    do{
                        let questionGroup = try JSONDecoder().decode([QuestionsGroup].self, from: data)
                        //print(finalResult)
                        
                        for questionAndOptions in questionGroup {
                            print("Question: ",questionAndOptions.question)
                            for option in questionAndOptions.options {
                                print (option.option)
                                
                            }
                        }
                        
                        DispatchQueue.main.sync(execute: {
                        })
                        
                        
                    } catch let jsonError{
                        print("Error while deconding the json: " , jsonError)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

