//
//  ViewController.swift
//  SampleHealthApp
//
//  Created by pratul patwari on 11/15/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit
import HealthKit
import HealthKitUI

struct HealthData {
    var date : Date
    var value : Int
}

class ViewController: UIViewController {

    let healthStore = HKHealthStore()
    var isAuthorized : Int = 0
    var dictionary = [Date : Int]()
    var healthData = [HealthData]()
    
    let label : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .gray
        return l
    }()
    
    let label1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    let button : UIButton = {
        let b = UIButton()
        b.backgroundColor = .black
        b.setTitle("Button", for: .normal)
        b.addTarget(self, action: #selector(sendObserver), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        
        // Step 1
        guard HKHealthStore.isHealthDataAvailable() else {
            //completion(false, HealthkitSetupError.notAvailableOnDevice)
            // display an alert stating you don't have Health App in your mobile,
            // please contact your medical facility for next steps
            return
        }
        
        checkAuthorization()
    }
    
    func checkAuthorization(){
        isAuthorized = healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!).rawValue
        if (isAuthorized==1) {
            getTodaysTotalSteps(completion: { (steps) in
                print("Total step count recorded today: ",Int(steps))
                DispatchQueue.main.async {
                    self.label.text = String(Int(steps))
                }
                self.getDetailData()
            })
        } else {
            print("Not authorized to get step count data")
            authorizeHealthKit()
        }
    }
    
    func setupView(){
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.addSubview(label1)
        label1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50).isActive = true
        label1.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        label1.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
    }
    
    func authorizeHealthKit(){
        let dataTypeList = prepareDataTypes()
        
        healthStore.requestAuthorization(toShare: nil, read: dataTypeList) { (success, error) in
            if !success {
                print("Error is requesting for authorization")
                DispatchQueue.main.async {
                    self.isAuthorized = 0
                }
            } else {
                print("Successfully authorized by user")
                DispatchQueue.main.async {
                    self.isAuthorized = 1
                    self.getTodaysTotalSteps(completion: { (steps) in
                        print("Total step count recorded today: ",Int(steps))
                        DispatchQueue.main.async {
                            self.label.text = String(Int(steps))
                        }
                        self.getDetailData()
                    })
                }
            }
        }
    }
    
    func getDetailData(){

        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        // unit has to be either day or hour
        let (startDate, interval) = self.getQueryParameters(day: 20, intrvl: 1, unit: "day")

        self.getStepsData(quantityType: stepsQuantityType, startDate: startDate, interval: interval) { dict in
            for (quantity,statistics) in dict {
                self.dictionary[statistics.startDate] = Int(quantity.doubleValue(for: HKUnit.count()))
            }
            DispatchQueue.main.async {
                let sortedDic = self.dictionary.sorted { (aDic, bDic) -> Bool in
                    return aDic.key < bDic.key
                }
                for (key,value) in sortedDic {
                    print(key, "   ->    ", value)
                    self.healthData.append(HealthData(date: key, value: value))
                }

                if let str = sortedDic.first?.value {
                    self.label1.text = String(str)
                }
            }
        }
    }
    
    
    @objc func sendObserver(){
        let controller = TableViewController()
        controller.health = healthData
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func getQueryParameters(day: Int, intrvl: Int, unit: String) -> (Date, DateComponents){
        let calendar = Calendar.current
        var startDate = Date()
        let range = calendar.date(byAdding: .day, value: -day, to: Date())
        var interval = DateComponents()
        if (day > 1) {
            startDate = Calendar.current.startOfDay(for: range!)
            unit=="day" ? (interval.day = intrvl) : (interval.hour = intrvl)
        } else {
            startDate = Calendar.current.startOfDay(for: Date())
            interval.hour = intrvl
        }
        
        return (startDate, interval)
    }
    
    // step 2
    func prepareDataTypes() -> Set<HKObjectType>{
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
        let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
        let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
        let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
        let height = HKObjectType.quantityType(forIdentifier: .height),
        let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
        let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass) else {
            print("Error in preparing Data types")
            let healthKitTypeToRead: Set<HKObjectType> = []
            return healthKitTypeToRead
        }
        
        // Step 3
        let healthKitTypeToRead: Set<HKObjectType> = [dateOfBirth,bloodType,biologicalSex,bodyMassIndex,height,stepCount,bodyMass]
        
        return healthKitTypeToRead
    }
    
    func getTodaysTotalSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result,
                let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    func getStepsData(quantityType: HKQuantityType, startDate: Date, interval :DateComponents, completion: @escaping ([HKQuantity:HKStatistics]) -> Void) {
        
        let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: startDate, intervalComponents: interval)
        
        var data = [HKQuantity : HKStatistics]()
        
        query.initialResultsHandler = {
            query, results, error in
            guard let statsCollection = results else {
                // Perform proper error handling here
                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
            }
            statsCollection.enumerateStatistics(from: startDate, to: Date(), with: { (statistics, solve) in
                if let quantity = statistics.sumQuantity() {
                    //completion(quantity, statistics)
                    data[quantity] = statistics
                }
            })
            completion(data)
        }
        healthStore.execute(query)
    }
    
    func getAgeSexAndBloodType() throws -> (age: Int,
                                        biologicalSex: HKBiologicalSex,
                                        bloodType: HKBloodType){
        do{
            let birthComponent = try healthStore.dateOfBirthComponents()
            let biologicalSex = try healthStore.biologicalSex()
            let bloodType = try healthStore.bloodType()
            
            let todayDate = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year], from: todayDate)
            
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthComponent.year!
            
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
            
            return(age,unwrappedBiologicalSex,unwrappedBloodType)
        }
    }
}
