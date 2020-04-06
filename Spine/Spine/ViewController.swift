//
//  ViewController.swift
//  Spine
//
//  Created by pratul patwari on 4/3/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
    }

    private func setupTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            return 12
        case 2:
            return 5
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height / 25)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.layer.cornerRadius = 5
        var color = UIColor()
        var width = 0
        var title = String()
        let name = String(indexPath.row + 1)
        switch indexPath.section {
        case 0:
            color = .gray
            title = "C"+name
            width = 40
            
        case 1:
            color = .blue
            title = "T"+name
            width = 60
        case 2:
            color = .yellow
            title = "L"+name
            width = 70
        case 3:
            color = .darkGray
            cell.bilateral.titleLabel?.text = name
            width = 100
        default:
            cell.backgroundColor = .white
        }
        cell.label.text = title + " - "
        cell.bilateral.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        (cell.left.backgroundColor,cell.bilateral.backgroundColor,cell.right.backgroundColor) = (color,color,color)
        cell.left.addTarget(self, action: #selector(handleLeft), for: .touchUpInside)
        cell.bilateral.addTarget(self, action: #selector(handleBilateral), for: .touchUpInside)
        cell.right.addTarget(self, action: #selector(handleRight), for: .touchUpInside)
        return cell
    }
    
    var selectedIndex = IndexPath()
    var select = String()
    var selected: Bool = false
    var customCell = CustomCell()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selected {
            if indexPath != selectedIndex {
                let previous = tableView.cellForRow(at: selectedIndex) as! CustomCell
                previous.result.text = ""
                selectedIndex = indexPath
            }
        } else {
            selected = true
            selectedIndex = indexPath
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        (cell.left.backgroundColor,cell.bilateral.backgroundColor,cell.right.backgroundColor) = (.red,.red,.red)
        (cell.left.isEnabled, cell.bilateral.isEnabled, cell.right.isEnabled) = (true,true,true)
        select = cell.label.text!
        customCell = cell
    }
    
    @objc func handleLeft(){
        customCell.result.text = "Left"
    }
    @objc func handleBilateral(){
        customCell.result.text = "Bilateral"
    }
    @objc func handleRight(){
        customCell.result.text = "right"
    }
}

