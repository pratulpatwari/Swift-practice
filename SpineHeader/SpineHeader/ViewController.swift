//
//  ViewController.swift
//  SpineHeader
//
//  Created by pratul patwari on 4/3/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var expand = false
    var tableView: UITableView!
    var numberSections = 24
    
    let button: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(QuestionCell.self, forCellReuseIdentifier: "question")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberSections
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.size.height / 25
    }
    
    var selected = [Int]()
    @objc func handleGesture(custom: CustomTapGesture) -> Void {
        print("Section Number: ", custom.section)
        var indices = [IndexPath]()
        indices.append(IndexPath(row: 0, section: custom.section))
        indices.append(IndexPath(row: 1, section: custom.section))
        if !selected.contains(custom.section) {
            selected.append(custom.section)
            //tableView.insertRows(at: indices, with: .left)
            tableView.reloadData()
        } else {
            selected.removeAll { (element) -> Bool in
                return element == custom.section
            }
//            tableView.deleteRows(at: indices, with: .right)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 2, height: 20))
        let tap = CustomTapGesture(target: self, action: #selector(handleGesture))
        tap.section = section
        headerView.addGestureRecognizer(tap)
        //headerView.backgroundColor = .red
        
        let left = UILabel()
        left.layer.cornerRadius = 8
        left.layer.maskedCorners = [.layerMinXMaxYCorner]
        left.layer.masksToBounds = true
        left.translatesAutoresizingMaskIntoConstraints = false
        
        let bilateral = UILabel()
        //bilateral.text = "B"
        bilateral.textAlignment = .center
        //bilateral.layer.cornerRadius = 2
        //bilateral.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bilateral.layer.masksToBounds = true
        bilateral.layer.shadowColor = UIColor.black.cgColor
        bilateral.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bilateral.layer.shadowOpacity = 0.2
        bilateral.layer.shadowRadius = 4.0
        bilateral.translatesAutoresizingMaskIntoConstraints = false
        
        let disc = UIView()
        disc.translatesAutoresizingMaskIntoConstraints = false
        disc.backgroundColor = UIColor(red: 217 / 255, green: 218 / 255, blue: 230 / 255, alpha: 1)
        
        let right = UILabel()
        right.layer.cornerRadius = 8
        right.layer.maskedCorners = [.layerMaxXMaxYCorner]
        right.layer.masksToBounds = true
        right.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(left)
        headerView.addSubview(bilateral)
        headerView.addSubview(disc)
        headerView.addSubview(right)
        
        bilateral.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        bilateral.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        bilateral.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -2).isActive = true
        
        
        disc.leftAnchor.constraint(equalTo: bilateral.leftAnchor).isActive = true
        disc.rightAnchor.constraint(equalTo: bilateral.rightAnchor).isActive = true
        disc.topAnchor.constraint(equalTo: bilateral.bottomAnchor).isActive = true
        disc.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        left.rightAnchor.constraint(equalTo: bilateral.leftAnchor, constant: 0).isActive = true
        left.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        left.widthAnchor.constraint(equalToConstant: headerView.frame.size.width / 8).isActive = true
        left.heightAnchor.constraint(equalToConstant: headerView.frame.height / 2).isActive = true
        
        right.leftAnchor.constraint(equalTo: bilateral.rightAnchor, constant: 0).isActive = true
        right.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        right.widthAnchor.constraint(equalToConstant: headerView.frame.size.width / 8).isActive = true
        right.heightAnchor.constraint(equalToConstant: headerView.frame.height / 2).isActive = true
        
        if section < 7 {
            (left.backgroundColor, bilateral.backgroundColor, right.backgroundColor) = (.gray, .gray, .gray)
            bilateral.widthAnchor.constraint(equalToConstant: headerView.frame.size.width / 6).isActive = true
            bilateral.text = "C\(section+1)"
        } else if section < 19 {
            (left.backgroundColor, bilateral.backgroundColor, right.backgroundColor) = (#colorLiteral(red: 0.3275212359, green: 0.3844603674, blue: 1, alpha: 1), #colorLiteral(red: 0.3275212359, green: 0.3844603674, blue: 1, alpha: 1), #colorLiteral(red: 0.3275212359, green: 0.3844603674, blue: 1, alpha: 1))
            bilateral.widthAnchor.constraint(equalToConstant: headerView.frame.size.width / 4).isActive = true
            bilateral.text = "T\(section+1 - 7)"
        } else {
            (left.backgroundColor, bilateral.backgroundColor, right.backgroundColor) = (.yellow, .yellow, .yellow)
            bilateral.widthAnchor.constraint(equalToConstant: headerView.frame.size.width / 3).isActive = true
            bilateral.text = "L\(section+1 - 19)"
        }
        
        if selected.contains(section){
            (left.backgroundColor, bilateral.backgroundColor, right.backgroundColor) = (.red, .red, .red)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selected.contains(section) {
            return 0
        } else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "question", for: indexPath) as! QuestionCell
        if indexPath.row == 0 {
            cell.question.text = "Side: "
        }  else {cell.question.text = "Type: "}
        cell.label.text = "Left"
        return cell
    }
}

class CustomTapGesture: UITapGestureRecognizer {
    var indexPath = IndexPath()
    var section = Int()
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

