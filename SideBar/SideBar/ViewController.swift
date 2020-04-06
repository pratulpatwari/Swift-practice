//
//  ViewController.swift
//  SideBar
//
//  Created by pratul patwari on 12/14/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate {
    
    
    let cellId = "cellId"
    let labels : [String] = ["Home","Videos","Settings"]
    var isSideViewOpen: Bool = false
    var counter: Int = 0
    var custom = [CustomURL]()
    
    let MIRUS_THEME = UIColor.init(red: 177 / 255, green: 31 / 255, blue: 42 / 255, alpha: 1.0)
    
    let sideView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sideTable : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 50
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        return tableView
    }()
    
    
    let label : UILabel = {
        let l = UILabel()
        l.text = "Hello"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Hello"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Lines", style: .done, target: self, action: #selector(handleToggle))
        
        sideTable.isHidden = false
        isSideViewOpen = false
        setupSideView()
    }
    
    fileprivate func setupLabel(){
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupSideView(){
        view.addSubview(sideTable)
        
        sideTable.delegate = self
        sideTable.dataSource = self
        sideTable.separatorStyle = .none
        sideTable.backgroundColor = MIRUS_THEME
        sideTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        sideTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        sideTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideTable.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = labels[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "GillSans-SemiBold", size: 25)
        cell.backgroundColor = MIRUS_THEME
        cell.tintColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            setupDictionary { (custom) in
                self.sideTable.isHidden = true
                self.sideTable.reloadData()
            }
        }
    }
    
    var webView: WKWebView?
    
    fileprivate func setupDictionary(completion: @escaping ([CustomURL])->()){
        var dictionary = [URLS]()
        dictionary.append(URLS(name: "Foraminotomy (Lumbar Spine)", url: "https://viewmedica.com/ondemand-patient-education-videos/see-videos/#A_1def9152"))
        dictionary.append(URLS(name: "Anterior Cervical Discectomy and Fusion (ACDF)", url: "https://viewmedica.com/ondemand-patient-education-videos/see-videos/#A_58b2201c"))
        dictionary.append(URLS(name: "Total Knee Replacement", url: "https://viewmedica.com/ondemand-patient-education-videos/see-videos/#A_78706f97"))
        dictionary.append(URLS(name: "Endoscopic Plantar Fasciotomy (EPF)", url: "https://viewmedica.com/ondemand-patient-education-videos/see-videos/#A_abf0a394"))
        
        dictionary.forEach { (val) in
            custom.append(CustomURL(name: val.name, value: self.setupWebView(link: val.url)))
        }
        
        DispatchQueue.main.async {
            completion(self.custom)
        }
    }
    
    var subView: UIView = {
        let sub = UIView()
        sub.backgroundColor = .gray
        sub.translatesAutoresizingMaskIntoConstraints = false
        return sub
    }()
    
    func setupWebView(link : String) -> UIView{
        self.webView = WKWebView()
        self.webView?.translatesAutoresizingMaskIntoConstraints = false
        self.subView = self.webView!
        webView?.navigationDelegate = self
        
        webView?.scrollView.isScrollEnabled = false
        
        self.webView!.sizeToFit()
        self.webView!.frame = self.subView.frame
        
        let url = URL(string: link)
        let req = URLRequest(url: url!)
        self.webView!.load(req)
        
        return subView
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Data received for ")
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        counter += 1
        
        if counter == custom.count {
            print("All finished")
            let controller = ATableViewController()
            controller.custom = custom
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func handleToggle(){
        if sideTable.isHidden {
            sideTable.isHidden = false
            sideTable.alpha = 1.0
        } else {
            sideTable.isHidden = true
            
        }
    }
}

