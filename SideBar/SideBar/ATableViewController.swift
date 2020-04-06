//
//  ATableViewController.swift
//  SideBar
//
//  Created by pratul patwari on 12/17/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import WebKit

struct URLS {
    let name: String
    let url: String
}

struct CustomURL {
    let name: String
    let value: UIView
}

class ATableViewController: UITableViewController {
    
    var custom = [CustomURL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ATableCell.self, forCellReuseIdentifier: "cellId")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return custom.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ATableCell
        tableView.tableFooterView = UIView()
        let url = custom[indexPath.row]
        cell.label.text = url.name
        cell.setupView(subView: url.value)
        return cell
    }
    
    
    var subView: UIView = {
        let sub = UIView()
        sub.backgroundColor = .gray
        sub.translatesAutoresizingMaskIntoConstraints = false
        return sub
    }()
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

class ATableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var containerView: UIView = {
        let sub = UIView()
        sub.backgroundColor = .gray
        sub.translatesAutoresizingMaskIntoConstraints = false
        return sub
    }()
    
    var label: UILabel = {
        let l = UILabel()
        l.text = "Hello"
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    func setupView(subView : UIView){
        self.containerView = subView
        addSubview(self.containerView)
        addSubview(self.label)
        
        self.containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        label.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
