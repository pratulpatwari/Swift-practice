//
//  ViewController.swift
//  FirebaseSocialLogin
//
//  Created by pratul patwari on 6/13/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Succesfully logged in with facebook")
    }
}

