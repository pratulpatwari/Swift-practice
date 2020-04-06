//
//  SurveyController.swift
//  FitbitPage
//
//  Created by pratul patwari on 11/5/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

struct Survey {
    let surveyId: Int64
    let surveyName : String
    let surveyDesc: String
    let createTime: String
    let updateTime: String
    let question : [Question]
}
struct Question{
    let questionId: Int64
    let questionText: String
    let description: String
    let points: Int
    let createTime: String
    let updateTime: String
    let options : [Options]
}

struct Options {
    let optionId : Int64
    let optionText: String
    let optionPoint: Int
    let createTime: String
    let updateTime: String
}

struct PatientSurvey{
    let id: Int64
    let survey : Survey
    let status : String
    let assignedDate : String
    let submitTime : String
}

class SurveyController: UITableViewController {
    
    var patientSurvey = [PatientSurvey]()
    var assignedSurvey = [PatientSurvey]()
    lazy var completedSurvey = [PatientSurvey]()
    
    let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 227 / 255, green: 255 / 255, blue: 224 / 255, alpha: 1.0)
        return view
    }()
    
    let segment : UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Assigned","Completed"])
        segmented.selectedSegmentIndex = 0
        segmented.tintColor = .red
        segmented.backgroundColor = UIColor.white
        segmented.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        createSurveyQuestions()
        setupNavigationBar(title: "Patient Survey List")
        
        assignedSurvey = patientSurvey.filter { (ps) -> Bool in
            ps.status == "Assigned"
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch(segment.selectedSegmentIndex){
        case 0:
            return assignedSurvey.count
        case 1:
            return completedSurvey.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.addSubview(headerView)
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        headerView.addSubview(segment)
        
        segment.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        segment.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.7).isActive = true
        segment.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        switch(segment.selectedSegmentIndex){
        case 0:
            cell.textLabel?.text = assignedSurvey[indexPath.row].survey.surveyName
            break
        case 1:
            cell.textLabel?.text = completedSurvey[indexPath.row].survey.surveyName
            break
        default:
            cell.textLabel?.text = "Survey name not known"
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = Questionnaire()
        switch(segment.selectedSegmentIndex){
        case 0:
            controller.survey = assignedSurvey[indexPath.row].survey
            break
        case 1:
            controller.survey = completedSurvey[indexPath.row].survey
            break
        default:
            break
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print(sender.selectedSegmentIndex, " is clicked")
        switch (segment.selectedSegmentIndex) {
        case 0:
            // load Assigned
            
            tableView.reloadData()
            break
        case 1:
            // load completed.
            // This is for memory management as all users might not go to completed survey page
            completedSurvey = patientSurvey.filter { (ps) -> Bool in
                ps.status == "Completed"
            }
            tableView.reloadData()
        default:
            break
        }
    }
    
    private func createSurveyQuestions(){
        patientSurvey.append(PatientSurvey(id: 1, survey: Survey(surveyId: 1,
                                                                 surveyName: "Oswestry Low back Pain Disability Questionnair", surveyDesc: "ODI", createTime: "", updateTime: "",
                                                                 question: [Question(questionId: 1, questionText: "Section 1 – Pain intensity", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 1, optionText: "I have no pain at the moment", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 2, optionText: "The pain is very mild at the moment", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 3, optionText: "The pain is moderate at the moment ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 4, optionText: "The pain is fairly severe at the moment", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 5, optionText: "The pain is very severe at the moment ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 6, optionText: "The pain is the worst imaginable at the moment", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 2, questionText: "Section 2 – Personal care (washing, dressing etc) ", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 7, optionText: "I can look after myself normally without causing extra pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 8, optionText: "I can look after myself normally but it causes extra pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 9, optionText: "It is painful to look after myself and I am slow and careful", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 10, optionText: "I need some help but manage most of my personal care ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 11, optionText: "I need help every day in most aspects of self-care ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 12, optionText: "I do not get dressed, I wash with difficulty and stay in bed", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 3, questionText: "Section 3 – Lifting", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 13, optionText: "I can lift heavy weights without extra pain ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 14, optionText: "I can lift heavy weights but it gives extra pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 15, optionText: "Pain prevents me from lifting heavy weights off the floor, but I can manage if they are conveniently placed eg. on a table ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 16, optionText: "Pain prevents me from lifting heavy weights, but I can manage light to medium weights if they are conveniently positioned ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 17, optionText: "I can lift very light weights ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 18, optionText: "I cannot lift or carry anything at all ", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 4, questionText: "Section 4 – Walking*", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 19, optionText: "Pain does not prevent me walking any distance ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 20, optionText: "Pain prevents me from walking more than 1 mile", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 21, optionText: "Pain prevents me from walking more than 0.5 mile ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 22, optionText: "Pain prevents me from walking more than 100 yards", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 23, optionText: "I can only walk using a stick or crutches", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 24, optionText:  "I am in bed most of the time", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 5, questionText: "Section 5 – Sitting", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 25, optionText: "I can sit in any chair as long as I like", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 26, optionText: "I can only sit in my favourite chair as long as I like ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 27, optionText: "Pain prevents me sitting more than one hour", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 28, optionText: "Pain prevents me from sitting more than 30 minutes ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 29, optionText: "Pain prevents me from sitting more than 10 minutes ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 30, optionText: "Pain prevents me from sitting at all", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 6, questionText: "Section 6 – Standing", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 31, optionText: "I can stand as long as I want without extra pain ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 32, optionText: "I can stand as long as I want but it gives me extra pain  ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 33, optionText: "Pain prevents me from standing for more than 1 hour", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 34, optionText: "Pain prevents me from standing for more than 30 minutes ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 35, optionText: "Pain prevents me from standing for more than 10 minutes ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 36, optionText: "Pain prevents me from standing at all ", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 7, questionText: "Section 7 – Sleeping", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 37, optionText: "My sleep is never disturbed by pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 38, optionText: "My sleep is occasionally disturbed by pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 39, optionText: "Because of pain I have less than 6 hours sleep", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 40, optionText: "Because of pain I have less than 4 hours sleep", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 41, optionText: "Because of pain I have less than 2 hours sleep", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 42, optionText: "Pain prevents me from sleeping at all", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 8, questionText: "Section 8 – Sex life (if applicable) ", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 43, optionText: "My sex life is normal and causes no extra pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 44, optionText: "My sex life is normal but causes some extra pain ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 45, optionText: "My sex life is nearly normal but is very painful ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 46, optionText: "My sex life is severely restricted by pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 47, optionText: "My sex life is nearly absent because of pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 48, optionText: "Pain prevents any sex life at all ", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 9, questionText: "Section 9 – Social life", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 49, optionText: "My social life is normal and gives me no extra pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 50, optionText: "My social life is normal but increases the degree of pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 51, optionText: "Pain has no significant effect on my social life apart from limiting my more energetic interests eg, sport", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 52, optionText: "Pain has restricted my social life and I do not go out as often", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 53, optionText: "Pain has restricted my social life to my home", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 54, optionText: "I have no social life because of pain", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            
                                                                            Question(questionId: 10, questionText: "Section 10 – Travelling", description: "", points: 5, createTime: "", updateTime: "",
                                                                                     options: [Options(optionId: 55, optionText: "I can travel anywhere without pain", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 56, optionText: "I can travel anywhere but it gives me extra pain ", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 57, optionText: "Pain is bad but I manage journeys over two hours", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 58, optionText: "Pain restricts me to journeys of less than one hour", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 59, optionText: "Pain restricts me to short necessary journeys under 30 minutes", optionPoint: 5, createTime: "", updateTime: ""),
                                                                                               Options(optionId: 60, optionText: "Pain prevents me from travelling except to receive treatment ", optionPoint: 5, createTime: "", updateTime: "")]),
                                                                            ]), status: "Assigned", assignedDate: "", submitTime: ""))
        
        patientSurvey.append(PatientSurvey(id: 2, survey: Survey(surveyId: 2, surveyName: "Completed Survey", surveyDesc: "Some other Survey", createTime: "", updateTime: "", question: [Question(questionId: 11, questionText: "Question 1", description: "", points: 5, createTime: "", updateTime: "",  options: [Options(optionId: 61, optionText: "Options 1", optionPoint: 5, createTime: "", updateTime: "")])]), status: "Completed", assignedDate: "", submitTime: ""))
    }
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

