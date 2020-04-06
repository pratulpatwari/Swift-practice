//
//  ViewController.swift
//  NurseApp
//
//  Created by pratul patwari on 12/3/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cellId = "cellId"
    private var myTableView: UITableView!
    
    var details : [PatientDetails] = [PatientDetails]()
    
    let imagePickerController = UIImagePickerController()
    
    let img: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 10
        v.backgroundColor = UIColor.cyan
        return v
    }()
    
    let name: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.text = "Pratul Patwari"
        return n
    }()
    
    let designation: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont(name: "Helvetica Neue", size: 15.0)
        n.text = "Senior Nurse, Ward 5"
        return n
    }()
    
    let phone: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.font = UIFont(name: "Helvetica Neue", size: 12.0)
        n.text = "Phone: +1-617-751-8625"
        return n
    }()
    
    let toggle: UISwitch = {
        let s = UISwitch()
        s.isOn = true
        s.tintColor = .red
        s.onTintColor = .blue
        s.addTarget(self, action: #selector(toggleSwitch), for: .allTouchEvents)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let availability: UILabel = {
        let a = UILabel()
        a.translatesAutoresizingMaskIntoConstraints = false
        a.text = "Available"
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Dashboard"
        imagePickerController.delegate = self
        
        setupImagePicker()
        setupPatient()
        setupNurse()
        setupSwitch()
        setupTable()
    }
    
    fileprivate func setupImagePicker(){
        view.addSubview(img)
        
        img.tintColor = .blue
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
        
        img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        img.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    fileprivate func setupNurse(){
        view.addSubview(name)
        view.addSubview(designation)
        view.addSubview(phone)
        
        name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        name.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 20).isActive = true
        
        designation.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        designation.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 20).isActive = true
        
        phone.topAnchor.constraint(equalTo: designation.bottomAnchor, constant: 5).isActive = true
        phone.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 20).isActive = true
    }
    
    fileprivate func setupSwitch(){
        view.addSubview(toggle)
        view.addSubview(availability)
        toggle.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 20).isActive = true
        toggle.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 20).isActive = true
        
        availability.topAnchor.constraint(equalTo: toggle.topAnchor, constant: 5).isActive = true
        availability.leftAnchor.constraint(equalTo: toggle.rightAnchor, constant: 15).isActive = true
    }
    
    
    fileprivate func setupTable(){
        
        myTableView = UITableView()
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(PatientCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.tableFooterView = UIView()
        
        self.view.addSubview(myTableView)
        
        
        myTableView.topAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 10).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 5).isActive = true
        myTableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
    }
    
    
    @objc func imageTapped()
    {
        
        let alert = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            } else {
                print("No Camera")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            self.authorizeToAlbum { (authorized) in
                if authorized == true {
                    self.imagePickerController.delegate = self
                    self.imagePickerController.allowsEditing = true
                    self.imagePickerController.sourceType = .photoLibrary
                    self.present(self.imagePickerController, animated: true, completion: nil)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert,animated: true, completion: nil)
    }
    
    func authorizeToAlbum(completion:@escaping (Bool)->Void) {
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            NSLog("Will request authorization")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        completion(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
            
        } else {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.img.image = pickedImage
        }
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleSwitch(){
        if toggle.isOn{
            print("Make a call to server to mark Nurse available")
            availability.text = "Available"
        } else {
            print("Make a call to server to mark Nurse unavailable")
            availability.text = "Unavailable"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 0.7, height: 40))
        headerView.layer.cornerRadius = 5
        
        let patient = UILabel()
        patient.translatesAutoresizingMaskIntoConstraints = false
        patient.text = "Patient"
        headerView.addSubview(patient)
        patient.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        patient.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        
        
        let prom = UILabel()
        prom.translatesAutoresizingMaskIntoConstraints = false
        prom.text = "PROM"
        headerView.addSubview(prom)
        prom.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        prom.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        
        let steps = UILabel()
        steps.translatesAutoresizingMaskIntoConstraints = false
        steps.text = "Steps"
        headerView.addSubview(steps)
        steps.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        steps.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -60).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! PatientCell
        cell.accessoryType = .disclosureIndicator
        let list = details[indexPath.row]
        cell.details = list
        if indexPath.row % 2 == 0 {
            cell.dot.color = .blue
        } else {
            cell.dot.color = .red
            cell.patientName.textColor = .red
            cell.promScore.textColor = .red
            cell.stepCount.textColor = .red
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delay(0.1) {
            print("Row selected: \(indexPath.row)")
            self.changeController(patientDetails: self.details[indexPath.row])
        }
        
    }
    
    func delay(_ delay: Double, closure: @escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    fileprivate func changeController(patientDetails: PatientDetails){
        let patientController = PatientViewController()
        patientController.patientDetails = patientDetails
        navigationController?.pushViewController(patientController, animated: false)
    }
    
    fileprivate func setupPatient(){
        details.append(PatientDetails(name:"PT-ID1206", score: "9.2/10",steps: "1956"))
        details.append(PatientDetails(name:"PT-ID1207", score: "7.8/10",steps: "2144"))
        details.append(PatientDetails(name:"PT-ID1208", score: "9.1/10",steps: "3454"))
        details.append(PatientDetails(name:"PT-ID1209", score: "8.2/10",steps: "641"))
        details.append(PatientDetails(name:"PT-ID1210", score: "6.4/10",steps: "1234"))
        details.append(PatientDetails(name:"PT-ID1211", score: "7.7/10",steps: "5432"))
        details.append(PatientDetails(name:"PT-ID1212", score: "8.5/10",steps: "5343"))
    }
    
}
