//
//  ViewController.swift
//  Table View and Loop
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // this will return the number of rows which needs to be rendered
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 50
    }
    
    // this will have the logic to fill those rows with data
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        // this is another approach with which we can achieve this task
//        var i = 1
//        var numbers = [Int]()
//        while i<=50{
//            numbers.append(i)
//            i += 1
//        }
        
        //cell.textLabel?.text = String(numbers[indexPath.row])
        
        // we don't need any loop here because the default function written above will be considered as loop
        // when it will render 50 cells
        cell.textLabel?.text = String(indexPath.row+1)
        
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

