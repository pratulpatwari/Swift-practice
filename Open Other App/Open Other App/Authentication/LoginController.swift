//
//  LoginController.swift
//  Open Other App
//
//  Created by pratul patwari on 6/14/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit


func storeKeys(accessObject: AccessObject){
    let now = Date()
    let expirationTime = now.addingTimeInterval(TimeInterval(accessObject.expires_in))
    
    UserDefaults.standard.set(accessObject.refresh_token, forKey: "refresh_token")
    UserDefaults.standard.set(expirationTime, forKey: "expiration_time")
    UserDefaults.standard.set(accessObject.access_token, forKey: "access_token")
}

let clientID = "22CZXG"
let clientSecret = "b12eb897edd9c61073700eb1c14e0d8f"
let baseAuthUrlString = "https://www.fitbit.com/oauth2/authorize?"
let baseTokenUrlString = "https://api.fitbit.com/oauth2/token?"
let deviceUrl = "https://api.fitbit.com/1/user/-/devices.json"
let baseURL = URL(string: baseAuthUrlString)
let redirectURI = "myapp://"
let defaultScope = "heartrate+activity+settings"

class LoginController: UIViewController, AuthenticationProtocol {

    var authenticationController: AuthenticationController?
    
    let loginButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.black, for: .normal)
        l.setTitle("Fitbit", for: .normal)
        l.layer.cornerRadius = 10
        l.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        authenticationController = AuthenticationController(delegate: self)
    }
    
    @objc func loginAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        //let dateTime = dateFormatter.date(from: String(expire_time))
        if let access = UserDefaults.standard.object(forKey: "access_token") as? String{
            if let expire_time = UserDefaults.standard.object(forKey: "expiration_time") as? Date {
                let now = Date()
                if now < expire_time {
                    print("Current Time: ", now)
                    print()
                    print("Token expiration time: ", expire_time)
                    print()
                    print("Access Token:             ", access)
                    print()
                    print("Token is valid. Calling the Fitbit server using the access token to fetch the data")
                    callFitbitServerData(accessToken: access)
                } else {
                    print("Last recevied access token has expired. Call for new access token using refresh token")
                    if let refresh = UserDefaults.standard.object(forKey: "refresh_token") as? String {
                        getAccessToken(token: nil, grantType: "refresh_token", refreshToken: refresh) { (accessObject) in
                            storeKeys(accessObject: accessObject)
                            self.callFitbitServerData(accessToken: accessObject.access_token)
                        }
                    }
                    
                }
            }
        } else{
            authenticationController?.login(fromParentViewController: self)
        }
    }
    
    fileprivate func setupLoginButton() {
        view.addSubview(loginButton)
        
        view.backgroundColor = .white
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        //loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        if let appURL = URL(string: "fitbit://"){
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Fitbit"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            }
            else {
                let alert = UIAlertController(title: "\(appName)", message: "The app named \(appName) is not installed. Please install the app from appstore", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert,animated: true,completion: nil)
            }
        }
    }
    
    
    
    func authorizationDidFinish(_ success: Bool) {

        FitbitAPI.sharedInstance.authorize(with: accessToken)
      
        let dataSyncController = DataSyncController()
        navigationController?.pushViewController(dataSyncController, animated: true)
        
    }
    
    func callFitbitServerData(accessToken: String){
        
        FitbitAPI.sharedInstance.authorize(with: accessToken)
        
        let dataSyncController = DataSyncController()
        navigationController?.pushViewController(dataSyncController, animated: true)
    }
}

