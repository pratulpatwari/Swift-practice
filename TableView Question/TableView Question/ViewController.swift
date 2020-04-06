//
//  ViewController.swift
//  TableView Question
//
//  Created by pratul patwari on 6/4/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

struct QuestionsGroup : Decodable {
    let question: String
    let options: [Options]
    let questionType : String
    var selectedAnswerIndex: Int?
}

struct Options : Decodable{
    //let key: String
    let option: String
}

struct PromResponse : Encodable,Decodable {
    let question : String
    let options : [PromOptions]
}

struct PromOptions : Encodable,Decodable {
    let option : String
}


var answerDictionary = [Int:[Int]]()

var choiceType = String()
var lastIndexSelected = NSIndexPath()

var questionList = [QuestionsGroup]()

//var answerArray = [Int]()

class QuestionController: UITableViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Question"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextQuestion))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        // this is the sample Header created with identifier
        tableView.register(QuestionHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        // this is the sample cell created with id= cellId
        tableView.register(AnswerCell.self, forCellReuseIdentifier: cellId)
        
        
        tableView.sectionHeaderHeight = 60 // set the header height where question will be displayed
        
        tableView.tableFooterView = UIView() // to remove extra rows from the screen
       
    }

     // this will return the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // this will give the index of current page
        if let index = navigationController?.viewControllers.index(of: self) {
            let question = questionList[index]
            let count = question.options.count
            if count > 0 {
                return count
            }
        }
        return 0
    }

    // Options
    // this will actually create the cell using the sample cell created at top with identifier cellId
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnswerCell
        cell.nameLabel.numberOfLines = 0; // to wrap the data in cell
        
        if let index = navigationController?.viewControllers.index(of: self) {
            let question = questionList[index]
            cell.nameLabel.text = question.options[indexPath.row].option
        }
        
        //cell.nameLabel.text = question.answers[indexPath.row]
        return cell
    }
    
    // Questions
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! QuestionHeader
        //navigationController?.viewControllers.index(of: QuestionController)
        if let index = navigationController?.viewControllers.index(of: self) {
            print("index which needs to be printed: ",index)
            let question = questionList[index]
            header.nameLabel.text = question.question//question.questionString
            choiceType = question.questionType
        }
        
        //header.nameLabel.text = question.questionString
        return header
    }
    
    var answerArray = [Int]()
    // this code is to display the final success page once all questions are answered
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsMultipleSelectionDuringEditing = false
        if choiceType == "M" {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                answerArray.remove(at: answerArray.index(of: indexPath.item)!)
                if answerArray.count == 0 {
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
            else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                answerArray.append(indexPath.item)
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
            
        else if choiceType == "S" {
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red:0.63, green:0.63, blue:0.63, alpha:1.0)
            
             // answer array can have only one value. This is how we limit the number of answers allowed for the question to 1
            if answerArray.count < 1 {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                answerArray.append(indexPath.item)
                //tableView.cellForRow(at: indexPath)?.selectedBackgroundView = backgroundView
                //print(tableView.cellForRow(at: indexPath)?.isSelected)
                navigationItem.rightBarButtonItem?.isEnabled = true
                lastIndexSelected = indexPath as NSIndexPath
                
            } else {
                    // if already selected option is selected then remove that option as selected and disable the next button
                if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
                    tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                    answerArray.removeAll()
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else {
                    tableView.cellForRow(at: lastIndexSelected as IndexPath)?.accessoryType = UITableViewCellAccessoryType.none
                    answerArray.removeAll()
                    lastIndexSelected.removingLastIndex()
                    tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                    answerArray.append(indexPath.item)
                    lastIndexSelected = indexPath as NSIndexPath // update the latest selected value
                }
                
            }
        }
    }
    
  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.allowsMultipleSelectionDuringEditing = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red:0.63, green:0.63, blue:0.63, alpha:1.0)
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        
        if choiceType == "M" {
            
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                answerArray.remove(at: answerArray.index(of: indexPath.item)!)
                if answerArray.count == 0 {
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
            else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                answerArray.append(indexPath.item)
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
            
        else if choiceType == "S" {
            
            // answer array can have only one value. This is how we limit the number of answers allowed for the question to 1
            if answerArray.count < 1 {
                tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
                answerArray.append(indexPath.item)
                tableView.cellForRow(at: indexPath)?.selectedBackgroundView = backgroundView
                navigationItem.rightBarButtonItem?.isEnabled = true
                lastIndexSelected = indexPath as NSIndexPath
                
            } else {
                // if already selected option is selected then remove that option as selected and disable the next button
                if (tableView.cellForRow(at: indexPath)?.isSelected) == true {
                    tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
                    answerArray.removeAll()
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else {
                    tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
                    answerArray.removeAll()
                    lastIndexSelected.removingLastIndex()
                    tableView.cellForRow(at: indexPath)?.selectedBackgroundView = backgroundView
                    answerArray.append(indexPath.item)
                    lastIndexSelected = indexPath as NSIndexPath // update the latest selected value
                }
                
            }
        }
    }*/
    
    
    @objc func nextQuestion(){
        //print("Next button pressed")
        if let index = navigationController?.viewControllers.index(of: self) {
            answerDictionary[index] = answerArray
            if index < questionList.count - 1 {
                let questionController = QuestionController()
                navigationController?.pushViewController(questionController, animated: true)
            }
            else{
                let controller = ResultController()
                controller.answersSelected = answerDictionary
                navigationItem.backBarButtonItem?.isEnabled = false
                print(controller.answersSelected)
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
}

// this is controller class for Final page which will show up after all the questions are answered
class ResultController : UIViewController {
    
    var answersSelected = [Int:[Int]]()
    
    let resultLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 110.0, y: 80.0, width: 100.0, height: 30.0))
        label.text = "Thanks for submitting the survey"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let homeButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 110.0, y: 100.0, width: 150.0, height: 30.0))
        button.setTitle("Home", for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Completed !!!"
        
        print("Answers selected for questions are: ", answersSelected)
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .orange
        button.setTitle("Home", for: .normal)
        button.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        self.view.addSubview(resultLabel)

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultLabel]))
        
    }
    
    @objc func goToHome(){
        
        submitSurvey()
    }
}

private func submitSurvey(){
    
    print("Answer Dictionary : ", answerDictionary)
    print()
    print()
    print()
    
    let serverEndPoint: String = "http://pratuls-macbook-air.local:8090/postQuestions"
    
    guard let submitURL = URL(string: serverEndPoint) else {
        print("Error: cannot create URL")
        return
    }
    var surveySubmitUrlRequest = URLRequest(url: submitURL)
    
    surveySubmitUrlRequest.httpMethod = "POST"
    surveySubmitUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    var response = [PromResponse]()
    var responseOptions = [PromOptions]()
    for (key,value) in answerDictionary {
        for val in value {
            responseOptions.append(PromOptions(option: String(val)))
        }
        response.append(PromResponse(question: String(key), options: responseOptions))
        responseOptions.removeAll()
    }
    print("Response which will be sent from mobile:    ",response)
    
    print()
    print()
    print()
    
    do {
        let jsonBody = try JSONEncoder().encode(response)
        surveySubmitUrlRequest.httpBody = jsonBody
        print("Encoded json body: ",jsonBody)
        print("Data sent from Mobile:     ", response)
        print()
        print()
        print()
        print()
        print()
        
    } catch {
        print("Error in encoding")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: surveySubmitUrlRequest) { (data, _, _) in
        guard let data = data else { return }
        do {
            let jsonDecoded = try JSONDecoder().decode([PromResponse].self, from: data)
            print("Decoded Data:      ",jsonDecoded)
        } catch {
            print("Error in decoding")
        }
    }
    task.resume()
}

   // this controller is used to display the Question in the header
class QuestionHeader : UITableViewHeaderFooterView{
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Sample Question" //this text will be overwritten by the text sent through service call
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel])) // strech the table horizontly on screen
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel])) // strech the table vertically on the screen
    }
}

    // this controller is used to display possible options
class AnswerCell: UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        return label
    }()
    
    func setupView(){
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel])) // strech the table horizontly on screen
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel])) // strech the table vertically on the screen
    }
}


 // This should be the first controller which will display the type of survey
class ListController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Take Survey", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped to make a service call")
        
        serviceCallForQuestion {
            let questionController = QuestionController()
            self.navigationController?.setViewControllers([questionController], animated: true)
            self.navigationController?.pushViewController(questionController, animated: true)
        }
        
    }
    
    private func serviceCallForQuestion(completion: @escaping ()->()){
        let baseUrl = "http://pratuls-macbook-air.local:8090/getQuestions"
        
        if let url = URL(string: baseUrl){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                guard let data = data else {return}
                if let error = error {
                    print(error)
                }
                else {
                    
                    do{
                        let questionGroup = try JSONDecoder().decode([QuestionsGroup].self, from: data)
                        
                        for questionAndOptions in questionGroup {
                            print("Question: ",questionAndOptions.question)
                            questionList.append(questionAndOptions)
                        }
                        
                        DispatchQueue.main.async {
                            completion()
                        }
                        
                    } catch let jsonError{
                        print("Error while deconding the json: " , jsonError)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    private func serviceCallForSurveyList(){
        let baseUrl = "http://pratuls-macbook-air.local:8090/getSurvey"
        
        if let url = URL(string: baseUrl){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                guard let data = data else {return}
                if let error = error {
                    print(error)
                }
                else {
                    
                    do{
                        let questionGroup = try JSONDecoder().decode([QuestionsGroup].self, from: data)
                        
                        for questionAndOptions in questionGroup {
                            print("Question: ",questionAndOptions.question)
                            questionList.append(questionAndOptions)
                        }
                        
                        DispatchQueue.main.async {
                            //completion()
                        }
                        
                    } catch let jsonError{
                        print("Error while deconding the json: " , jsonError)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
}
