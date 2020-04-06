//
//  NursePatientController.swift
//  ButtonPractice
//
//  Created by pratul patwari on 1/17/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class NursePatientController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    var pickerView: UIPickerView!
    var surveyList = [Survey]()
    var item: Survey? = nil
    lazy var show: Bool = false
    
    let assign : UIImage = {
        let image = UIImage(named: "survey_selected")!
        image.draw(in: CGRect(x: 0, y: 0, width: 5, height: 5))
        return image
    }()
    
    let assignButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor.init(red: 152 / 255, green: 244 / 255, blue: 164 / 255, alpha: 1)
        b.setTitle("Assign", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 1
        b.addTarget(self, action: #selector(handleAssign), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(AssignedCell.self, forCellReuseIdentifier: "assigned")
        tableView.register(CompletedSurveyCell.self, forCellReuseIdentifier: "completed")
        tableView.estimatedRowHeight = 100
        
        surveyList.append(Survey(name: "Lower Back Disability", assigned: "Pratul Patwari", assignedDate: "01/22/2019", completedDate: "", completed: false, score: nil))
        surveyList.append(Survey(name: "Knee Surgery", assigned: "Pratul Patwari", assignedDate: "01/22/2019", completedDate: "", completed: false, score: nil))
        surveyList.append(Survey(name: "Knee Surgery", assigned: "Pratul Patwari", assignedDate: "01/22/2019", completedDate: "01/22/2019", completed: true, score: 25))
        surveyList.append(Survey(name: "Lower Back Disability", assigned: "Pratul Patwari", assignedDate: "01/22/2019", completedDate: "01/22/2019", completed: true, score: 85))
        
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Assign", style: .done, target: self, action: #selector(showHidePicker)), animated: true)
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
        
        setupPickerView()
    }
    
    
    fileprivate func setupPickerView(){
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        view.addSubview(assignButton)
        pickerView.isHidden = true
        assignButton.isHidden = true
        
        pickerView.backgroundColor = UIColor.init(red: 151 / 255, green: 188 / 255, blue: 222 / 255, alpha: 1)
        pickerView.tintColor = .red
        pickerView.showsSelectionIndicator = true
        pickerView.layer.cornerRadius = 5
        
        pickerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        pickerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        assignButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor).isActive = true
        assignButton.leftAnchor.constraint(equalTo: pickerView.leftAnchor).isActive = true
        assignButton.rightAnchor.constraint(equalTo: pickerView.rightAnchor).isActive = true
        assignButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return surveyList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !pickerView.isHidden {
            updateValues(value: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if !surveyList[indexPath.row].completed {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            surveyList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            // make a DB call to remove the survey from patient
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !surveyList[indexPath.row].completed {
            let cell = tableView.dequeueReusableCell(withIdentifier: "assigned", for: indexPath) as! AssignedCell
            cell.accessoryType = .disclosureIndicator
            cell.name.text = surveyList[indexPath.row].name
            cell.dot.color = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
            cell.assignName.textColor = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
            cell.assignName.text = surveyList[indexPath.row].assigned
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath) as! CompletedSurveyCell
            cell.accessoryType = .disclosureIndicator
            if surveyList[indexPath.row].score! > 70 {
                cell.score.textColor = .red
                cell.dot.color = .red
            } else {
                cell.score.textColor = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
                cell.dot.color = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
            }
            cell.name.text = surveyList[indexPath.row].name
            cell.score.text = String(surveyList[indexPath.row].score!)
            cell.date.text = surveyList[indexPath.row].completedDate
            cell.date.textColor = .gray
            return cell
        }
    }

    @objc func showHidePicker(){
        if pickerView.isHidden {
            updateValues(value: false)
        } else {
            updateValues(value: true)
        }
    }
    
    private func updateValues(value: Bool) {
        pickerView.isHidden = value
        assignButton.isHidden = value
        tableView.isScrollEnabled = value
    }
    
    @objc func handleAssign(){
        guard let item = item else {return}
        print("Item to be assigned: ",item)
        updateValues(value: true)
        surveyList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        
        // make a call to DB to insert this row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return surveyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return surveyList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        item = surveyList[row]
    }
    
    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
 

    
    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
