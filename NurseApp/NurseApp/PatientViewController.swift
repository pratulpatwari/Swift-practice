//
//  PatientViewController.swift
//  NurseApp
//
//  Created by pratul patwari on 12/6/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit



class PatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var patientDetails: PatientDetails?
    
    let button: UIButton = {
        let b = UIButton()
        b.backgroundColor = .blue
        b.setTitle("Assign Survey", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.addTarget(self, action: #selector(handleAssignSurvey), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private var demographics: UITableView!
    
    private var surveys: UITableView!
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        setupName()
        setupDemographics()
        setupSurveys()
        guard let details = patientDetails else {return}
        print(details)
        navigationItem.title = details.name
    }
    
    @objc func handleAssignSurvey(){
        print("Assign Survey")
        navigationController?.pushViewController(AssignSurveyController(), animated: true)
    }
    
    fileprivate func setupName(){
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func setupDemographics(){
        
        demographics = UITableView()
        demographics.translatesAutoresizingMaskIntoConstraints = false
        demographics.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        demographics.dataSource = self
        demographics.delegate = self
        
        self.view.addSubview(demographics)
        
        
        demographics.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        demographics.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 1).isActive = true
        demographics.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -1).isActive = true
        demographics.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupSurveys(){
        
        surveys = UITableView()
        surveys.translatesAutoresizingMaskIntoConstraints = false
        surveys.register(UITableViewCell.self, forCellReuseIdentifier: "surveys")
        surveys.dataSource = self
        surveys.delegate = self
        
        self.view.addSubview(surveys)
        
        
        surveys.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        surveys.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        surveys.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        surveys.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.demographics {
            return 4
        } else{
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.demographics {
            return 1
        } else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if tableView == self.surveys {
            label.text = "Lower Back Disability"
            return label
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.demographics {
            return 0.0
        } else {
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.demographics {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            tableView.tableFooterView = UIView()
            setupDemographics(cell: cell)
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "surveys", for: indexPath)
            tableView.tableFooterView = UIView()
            cell.textLabel?.text = "\(indexPath.section) \(indexPath.row)"
            return cell
        }
        
    }
    
    fileprivate func setupDemographics(cell: UITableViewCell){
        let heading = UILabel()
        heading.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(heading)
        heading.text = "Key"
        heading.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        heading.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(value)
        value.text = "Value"
        value.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        value.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
    }
    
}
