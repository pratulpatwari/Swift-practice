//
//  FirstViewController.swift
//  To Do List
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: NSMutableArray = []
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
 
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        var cellLabel = ""
        
        if let tempLabel = items[indexPath.row] as? String{
            cellLabel = tempLabel
           
        }
         cell.textLabel?.text = cellLabel
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        if let tempItems = itemsObject as? NSMutableArray{
            items = tempItems
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

