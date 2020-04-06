//
//  DataSyncController.swift
//  Open Other App
//
//  Created by pratul patwari on 6/20/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import Foundation

let lastUpdateLabel : UILabel = {
    let label = UILabel()
    label.text = "Last Update"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
}()

let stepCounttLabel : UILabel = {
    let label = UILabel()
    label.text = "Steps Count"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
}()

class DataSyncController: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        setupResultLabel()
        
        SyncData.fetchDataSyncTime()
        
        StepStat.fetchTodaysStepStat() 
    }
    
    fileprivate func setupResultLabel(){
        view.addSubview(stepCounttLabel)
        view.addSubview(lastUpdateLabel)
        
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastUpdateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stepCounttLabel.translatesAutoresizingMaskIntoConstraints = false
        stepCounttLabel.topAnchor.constraint(equalTo: lastUpdateLabel.bottomAnchor, constant: 20).isActive = true
        stepCounttLabel.leftAnchor.constraint(equalTo: lastUpdateLabel.leftAnchor, constant: 0).isActive = true
        stepCounttLabel.rightAnchor.constraint(equalTo: lastUpdateLabel.rightAnchor, constant: 0).isActive = true
    }
}
