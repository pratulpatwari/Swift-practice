//
//  AuthenticationController.swift
//  Open Other App
//
//  Created by pratul patwari on 6/15/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import SafariServices

protocol AuthenticationProtocol {
    func authorizationDidFinish(_ success :Bool)
}

struct AccessObject: Codable {
    let access_token: String
    let expires_in : Int
    let refresh_token: String
    let scope: String
    let token_type: String
    let user_id: String
}

var finalToken = String()
//var authenticationToken = String()
var accessToken = String()
var refresh = String()
var expires = Int()


class AuthenticationController: NSObject, SFSafariViewControllerDelegate {

    var authViewController: SFSafariViewController?
    var delegate: AuthenticationProtocol?
    
    init(delegate: AuthenticationProtocol?) {
        self.delegate = delegate
        super.init()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: NotificationConstants.launchNotification), object: nil, queue: nil, using: { [weak self] (notification: Notification) in
            // Parse and extract token
            let success: Bool
            
            if let token = AuthenticationController.extractToken(notification, key: "?code") {
                UserDefaults.standard.set(token.replacingOccurrences(of: "#_=_", with: ""), forKey: "authentication_token")
                //authenticationToken = token.replacingOccurrences(of: "#_=_", with: "")
                success = true
            } else {
                print("There was an error extracting the access token from the authentication response.")
                success = false
            }

            if let authToken = UserDefaults.standard.object(forKey: "authentication_token") as? String {
                getAccessToken(token: authToken, grantType: "authorization_code" ,refreshToken: nil){(accessObject) in
                    
                    refresh = accessObject.refresh_token
                    expires = accessObject.expires_in
                    accessToken = accessObject.access_token
                    print()
                    print("Access Token: ", accessToken)
                    print()
                    print("Refresh Token: ", refresh)
                    print()
                    print("Token Expiration Time: ", expires / 60 / 60, " Hours")
                    print()
                    
                    storeKeys(accessObject: accessObject)
                    
                }
            }
            
            // this will dismiss the Safari page and will bring back to application using
            // scheme. Once that happens, this will call the authorizeDidFinish method in which we will
            // draft the url with access_token and will make a call to get the user data
            self?.authViewController?.dismiss(animated: true, completion: {
                self?.delegate?.authorizationDidFinish(success)
            })
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func login(fromParentViewController viewController: UIViewController) {
        let authUrl = baseAuthUrlString+"response_type=code"+"&client_id="+clientID+"&redirect_uri="+redirectURI+"&scope="+defaultScope
        
        guard let url = URL(string: authUrl) else {
            print("Unable to create authentication URL")
            return
        }
    
        let authorizationViewController = SFSafariViewController(url: url)
        authorizationViewController.delegate = self
        authViewController = authorizationViewController
        viewController.present(authorizationViewController, animated: true, completion: nil)
    }
    
    private static func extractToken(_ notification: Notification, key: String) -> String? {
        guard let url = notification.userInfo?[UIApplicationLaunchOptionsKey.url] as? URL else {
            print("notification did not contain launch options key with URL")
            return nil
        }
        
        // Extract the access token from the URL
        let strippedURL = url.absoluteString.replacingOccurrences(of: redirectURI, with: "")
        
        return self.parametersFromQueryString(strippedURL)[key]
    }
    
    private static func parametersFromQueryString(_ queryString: String?) -> [String: String] {
        var parameters = [String: String]()
        if (queryString != nil) {
            let parameterScanner: Scanner = Scanner(string: queryString!)
            var name:NSString? = nil
            var value:NSString? = nil
            while (parameterScanner.isAtEnd != true) {
                name = nil;
                parameterScanner.scanUpTo("=", into: &name)
                parameterScanner.scanString("=", into:nil)
                value = nil
                parameterScanner.scanUpTo("&", into:&value)
                parameterScanner.scanString("&", into:nil)
                if (name != nil && value != nil) {
                    parameters[name!.removingPercentEncoding!]
                        = value!.removingPercentEncoding!
                }
            }
        }
        return parameters
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        delegate?.authorizationDidFinish(false)
    }
    
}
