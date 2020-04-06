//
//  SecondViewController.swift
//  To Do List
//
//  Created by pratul patwari on 5/31/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var itemText: UITextField!
    
    @IBAction func addClick(_ sender: Any) {
        
        var items: NSMutableArray
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        if let tempItems = itemsObject as? NSMutableArray{
            items = tempItems
            items.addingObjects(from: [itemText.text!])
        }
        else{
             items = [itemText.text!]
        }
        
        UserDefaults.standard.set(items, forKey: "items")
        
        itemText.text = ""
    }
}

