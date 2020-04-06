//
//  ViewController.swift
//  PushNotificationTutorial
//
//  Created by pratul patwari on 11/26/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import UserNotifications

let pushNotification = "pushNotification"

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: pushNotification, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
