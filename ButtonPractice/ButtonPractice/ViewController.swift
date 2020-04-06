//
//  ViewController.swift
//  ButtonPractice
//
//  Created by pratul patwari on 1/16/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var demographics: UITableView!
    
    var data = Demographics(patientNumber: "PT 123", age: "31", sex: "Male", height: "6.1 feet", blood: "O+")
    
    let survey: UIButton = {
        let b = UIButton(type: .custom)
        b.tintColor = .white
        b.backgroundColor = UIColor(red: 128 / 255, green: 211 / 255, blue: 150 / 255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(surveyButton), for: .touchUpInside)
        return b
    }()
    
    let activity: UIButton = {
        let b = UIButton()
        b.tintColor = .white
        b.backgroundColor = UIColor(red: 255 / 255, green: 144 / 255, blue: 0 / 255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let chat: UIButton = {
        let b = UIButton()
        b.tintColor = .white
        b.backgroundColor = UIColor(red: 17 / 255, green: 189 / 255, blue: 194 / 255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let analytics: UIButton = {
        let b = UIButton()
        b.tintColor = .white
        b.backgroundColor = .white
        b.backgroundColor = UIColor(red: 255 / 255, green: 90 / 255, blue: 0 / 255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDemographics()
        setupButtons()
    }
    
    fileprivate func setupDemographics(){
        
        demographics = UITableView()
        demographics.translatesAutoresizingMaskIntoConstraints = false
        demographics.register(DemographCell.self, forCellReuseIdentifier: "cellId")
        demographics.dataSource = self
        demographics.delegate = self
        demographics.isScrollEnabled = false
        demographics.allowsSelection = false
        demographics.tableFooterView = UIView()
        
        self.view.addSubview(demographics)
        
        demographics.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        demographics.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        demographics.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50).isActive = true
        demographics.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50).isActive = true
        demographics.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupButtons(){
        view.addSubview(survey)
        view.addSubview(activity)
        view.addSubview(chat)
        view.addSubview(analytics)
        
        survey.topAnchor.constraint(equalTo: demographics.bottomAnchor, constant: 10).isActive = true
        survey.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        survey.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        survey.heightAnchor.constraint(equalToConstant: 150).isActive = true
        survey.optionButton()
        survey.contentHorizontalAlignment = .left
        survey.contentVerticalAlignment = .top
        survey.setTitle("Survey", for: .normal)
        let image = UIImage(named: "survey_selected")?.withRenderingMode(.alwaysTemplate)
        survey.setImage(image, for: .normal)
        let titleWidth = survey.titleLabel?.intrinsicContentSize.width
        survey.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth! * -0.75, bottom: 0, right: 0)
        survey.imageEdgeInsets = UIEdgeInsets(top: survey.intrinsicContentSize.height, left: survey.intrinsicContentSize.width / 2 - 10, bottom: 0, right: 0)
        
        
        activity.topAnchor.constraint(equalTo: demographics.bottomAnchor, constant: 10).isActive = true
        activity.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        activity.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        activity.heightAnchor.constraint(equalToConstant: 150).isActive = true
        activity.optionButton()
        activity.contentHorizontalAlignment = .left
        activity.contentVerticalAlignment = .top
        activity.setTitle("Activity", for: .normal)
        activity.setTitleColor(.white, for: .normal)
        let activityImage = UIImage(named: "activity")?.withRenderingMode(.alwaysTemplate)
        activity.setImage(activityImage, for: .normal)
        let activityWidth = activity.titleLabel?.intrinsicContentSize.width
        activity.titleEdgeInsets = UIEdgeInsets(top: 0, left: activityWidth! * -0.7, bottom: 0, right: 0)
        activity.imageEdgeInsets = UIEdgeInsets(top: activity.intrinsicContentSize.height, left: activity.intrinsicContentSize.width / 2 - 10, bottom: 0, right: 0)
        
        
        chat.topAnchor.constraint(equalTo: survey.bottomAnchor, constant: 20).isActive = true
        chat.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        chat.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        chat.heightAnchor.constraint(equalToConstant: 150).isActive = true
        chat.optionButton()
        chat.contentHorizontalAlignment = .left
        chat.contentVerticalAlignment = .top
        chat.setTitle("Chat", for: .normal)
        let chatImage = UIImage(named: "chat")?.withRenderingMode(.alwaysTemplate)
        chat.setImage(chatImage, for: .normal)
        let chatTitle = (chat.titleLabel?.intrinsicContentSize.width)!
        chat.titleEdgeInsets = UIEdgeInsets(top: 0, left: chatTitle * -1.1 , bottom: 0, right: 0)
        chat.imageEdgeInsets = UIEdgeInsets(top: chat.intrinsicContentSize.height, left: chat.intrinsicContentSize.width / 2, bottom: chat.intrinsicContentSize.height / 2, right: 0)
        
        
        analytics.topAnchor.constraint(equalTo: activity.bottomAnchor, constant: 20).isActive = true
        analytics.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        analytics.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        analytics.heightAnchor.constraint(equalToConstant: 150).isActive = true
        analytics.optionButton()
        analytics.contentHorizontalAlignment = .left
        analytics.contentVerticalAlignment = .top
        analytics.setTitle("Analytics", for: .normal)
        let analyticsImage = UIImage(named: "analytics")?.withRenderingMode(.alwaysTemplate)
        analytics.setImage(analyticsImage, for: .normal)
        let analyticsTitle = (analytics.titleLabel?.intrinsicContentSize.width)!
        analytics.titleEdgeInsets = UIEdgeInsets(top: 0, left: analyticsTitle * -0.55 , bottom: 0, right: 0)
        analytics.imageEdgeInsets = UIEdgeInsets(top: analytics.intrinsicContentSize.height, left: analytics.intrinsicContentSize.width / 3 + 10, bottom: analytics.intrinsicContentSize.height / 2, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DemographCell
        if indexPath.row == 0 {
            cell.label.text = "Age"
            cell.value.text = data.age
        } else if indexPath.row == 1 {
            cell.label.text = "Sex"
            cell.value.text = data.sex
        } else if indexPath.row == 2 {
            cell.label.text = "Blood Type"
            cell.value.text = data.blood
        } else if indexPath.row == 3 {
            cell.label.text = "Height"
            cell.value.text = data.height
        }
        return cell
    }
    
    @objc func surveyButton(){
        navigationController?.pushViewController(NursePatientController(), animated: true)
    }
}

extension UIButton {
    func optionButton(){
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 6
    }
}
