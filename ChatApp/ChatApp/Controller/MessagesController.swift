//
//  ViewController.swift
//  ChatApp
//
//  Created by pratul patwari on 12/11/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "message.png")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserLoggedIn()
    }
    
    @objc fileprivate func handleNewMessage(){
        let newMessageController = NewMessageController()
        present(UINavigationController(rootViewController: newMessageController), animated: true, completion: nil)
    }
    
    fileprivate func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout))
        } else {
            fetchUserAndSetupNavBarItem()
        }
    }
    
    func fetchUserAndSetupNavBarItem(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:String] {
                guard let name = dictionary["name"] else {return}
                print(name)
                self.navigationItem.title = name
            }
        }
    }
    
    let labelText : UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    func setupNavBarItem(completion: @escaping (String) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:String] {
                guard let name = dictionary["name"] else {return}
                self.navigationItem.title = name
                DispatchQueue.main.async {
                    completion(name)
                }
            }
        }
    }
    
    @objc func handleLogout(){
        
        do{
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}

