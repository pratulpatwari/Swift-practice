//
//  ViewController.swift
//  Questionnair
//
//  Created by pratul patwari on 10/24/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var survey = Survey(surveyId: 0, surveyName: "", surveyDesc: "", createTime: "", updateTime: "" ,question: [Question]())
    var currentQuestion = [Int : Int]()
    let cellId = "cellId"
    var questionIndex : Int = 0
    var response = [Int : Int]()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 50
        tableView.backgroundColor = .lightGray
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        return tableView
    }()
    
    let radioButton : UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "unchecked")
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }()
    
    let nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2.0;
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar(title: survey.surveyName)
        
        
        setupTableView()
        setupOptionsButton()
        setupNextButton()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(OptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func patientSurveyList(survey: Survey) {
        self.survey = survey
    }
    
    private func setupOptionsButton(){
        tableView.addSubview(radioButton)
    }
    
    private func setupNextButton(){
        view.addSubview(nextButton)
        
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return survey.question[questionIndex].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.currentQuestion[indexPath.item] = Int(survey.question[questionIndex].options[indexPath.item].optionId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OptionCell
        cell.nameLabel.text = survey.question[questionIndex].options[indexPath.row].optionText
        cell.nameLabel.numberOfLines = 0
        cell.accessoryType = .none
        cell.accessoryView = cell.radioButton
        cell.radioButton.setImage(UIImage(named: "unchecked.png"), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        tableView.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: self.tableView.sectionHeaderHeight).isActive = true
        header.text = survey.question[questionIndex].questionText
        header.textAlignment = .center
        header.numberOfLines = 0
        header.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        header.backgroundColor = .white
        return header
    }
    
    var lastSelectedIndex = IndexPath()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionCell
        if response.index(forKey: Int(survey.question[questionIndex].questionId)) != nil {
            let oldCell = tableView.cellForRow(at: lastSelectedIndex) as! OptionCell
            oldCell.radioButton.setImage(UIImage(named: "unchecked.png"), for: UIControl.State.normal)
            response[Int(survey.question[questionIndex].questionId)] = currentQuestion[indexPath.item]
            cell.radioButton.setImage(UIImage(named: "checked.png"), for: UIControl.State.normal)
        } else {
            response[Int(survey.question[questionIndex].questionId)] = currentQuestion[indexPath.item]
            cell.radioButton.setImage(UIImage(named: "checked.png"), for: UIControl.State.normal)
        }
        lastSelectedIndex = indexPath
    }
    
    @objc func handleNext(){
        
        if !lastSelectedIndex.isEmpty {
            
            if questionIndex == survey.question.count - 2 {
                print("Last question. Change the next button to Submit button")
                questionIndex += 1
                self.nextButton.setTitle("Submit", for: .normal)
                self.tableView.reloadTableWithAnimation(duration: 1.0, options: .curveLinear)
            }
            else if questionIndex < survey.question.count - 1 {
                questionIndex += 1
                self.tableView.reloadTableWithAnimation(duration: 1.0, options: .curveLinear)
            }
            else {
                displayConfirmationAlert()
            }
            lastSelectedIndex = IndexPath()
        }
    }
    
    private func displayConfirmationAlert(){
        print(response)
        print("Display Submit button and upon submitting send the response to server side")
        let alert = UIAlertController(title: "Survey Completed", message: "Thanks for submitting the survey", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "Submit", style: .default, handler: nil)
        let retake = UIAlertAction(title: "Retake", style: .default) { (action) in
            self.questionIndex = 0
            self.lastSelectedIndex = IndexPath()
            self.response.removeAll()
            self.currentQuestion.removeAll()
            self.nextButton.setTitle("Next", for: .normal)
            self.tableView.reloadTableWithAnimation(duration: 1.0, options: .curveLinear)
        }
        alert.addAction(confirm)
        alert.addAction(retake)
        self.present(alert, animated: true, completion: nil)
    }
}

class OptionCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Sample Answer" //this text will be overwritten by the text sent through service call
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let radioButton : UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        b.setTitle("radio", for: UIControl.State.normal)
        b.setImage(UIImage(named: "unchecked.png"), for: UIControl.State.normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    func setupView(){
        addSubview(radioButton)
        addSubview(nameLabel)
        
        radioButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        radioButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        radioButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        radioButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: radioButton.leftAnchor, constant: 40).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: radioButton.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}


extension UITableView {
    func reloadTableWithAnimation(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { self.alpha = 0 }, completion: nil)
        self.reloadData()
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { self.alpha = 1 }, completion: nil)
    }
}

extension UIButton {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
}

extension UIViewController {
    func setupNavigationBar(title : String){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: 80.0))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = title
        self.navigationItem.titleView = label
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: nil, action: nil)
    }
}
