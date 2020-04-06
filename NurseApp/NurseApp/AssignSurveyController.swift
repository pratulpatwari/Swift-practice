//
//  AssignSurveyController.swift
//  NurseApp
//
//  Created by pratul patwari on 12/7/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class AssignSurveyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var list: UITableView!
    
    let button: UIButton = {
        let b = UIButton()
        b.backgroundColor = .blue
        b.setTitle("Assign", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(handleAssignButton), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    

    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Select Disability"
        setupTable()
        setupButton()
    }
    
    fileprivate func setupTable(){
        list = UITableView()
        list.translatesAutoresizingMaskIntoConstraints = false
        list.register(DisabilityCell.self, forCellReuseIdentifier: "cellId")
        list.dataSource = self
        list.delegate = self
        list.tableFooterView = UIView()
        
        self.view.addSubview(list)
        
        list.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        list.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        list.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 5).isActive = true
        list.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    
    
    fileprivate func setupButton(){
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func handleAssignButton(){
        print("Assign selected Survey. Make a call to DB")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DisabilityCell
        cell.disability.text = "Lower back diability"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DisabilityCell
        if cell.checked {
            cell.checked = false
            cell.checkbox.image = UIImage(named: "unchecked.png")
        } else {
            cell.checked = true
            cell.checkbox.image = UIImage(named: "checked.png")
        }
    }
}
