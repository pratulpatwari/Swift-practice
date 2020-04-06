//
//  TabBarController.swift
//  FitbitPage
//
//  Created by pratul patwari on 11/5/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

let MIRUS_THEME = UIColor.init(red: 177 / 255, green: 31 / 255, blue: 42 / 255, alpha: 1)

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }
    
    private func setupTabBar(){
        
        let dashboardViewController = createNavController(vc: DashboardController(),title: "Dashboard",selectedImage: UIImage(named: "dashboard")!, unselectedImage: UIImage(named: "dashboard")!)
        
        let surveyViewController = createNavController(vc: SurveyController(), title: "Survey",selectedImage: UIImage(named: "survey_selected")!, unselectedImage: UIImage(named: "survey_selected")!)
        
        let fitbitViewController = createNavController(vc: FitbitController(), title:"Fitbit",selectedImage: UIImage(named: "fitbit_unselected")!, unselectedImage: UIImage(named: "fitbit_unselected")!)
        
        //let userViewController = createNavController(vc: UserViewController(), title:"User",selectedImage: #imageLiteral(resourceName: "user_unselected"), unselectedImage: #imageLiteral(resourceName: "user_unselected"))
        
        viewControllers = [dashboardViewController, surveyViewController, fitbitViewController/*, userViewController*/]
        
    }
}

extension UITabBarController {
    func createNavController(vc: UIViewController, title: String, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController{
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        UITabBar.appearance().tintColor = MIRUS_THEME
        return navController
    }
}
