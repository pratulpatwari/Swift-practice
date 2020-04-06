//
//  ViewController.swift
//  Table View
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Jordan", "Mahesh", "Jay", "Angad"]
    
    // public can be replaced with internal which means the scope of this method will be in this class
    // this will set and return the number of rows in table  view controller
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return cellContent.count
    }
    
    // this will return the index of cell and define each cell and add content to it
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
                                                            // this identifier is the cell which is set by us in UI
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        //cell.textLabel?.text = "Top Row" // this is setting the content of cell. This will eventually be replaced by data coming from service call
        cell.textLabel?.text = cellContent[indexPath.row]
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

