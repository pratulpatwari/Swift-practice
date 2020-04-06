//
//  ViewController.swift
//  MultiCollection
//
//  Created by pratul patwari on 1/28/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

//    let questions = ["In general, would you say your health is:","In general, would you say your quality of life is:."
//        ,"In general, how would you rate your physical health?", "In general, how would you rate your mental health, including your mood and your ability to think?",
//         "In general, how would you rate your satisfaction with your social activities and relationships?",
//         "In general, please rate how well you carry out your usual social activities and roles. (This includes activities at home, at work and in your community, and responsibilities as a parent, child, spouse, employee, friend, etc.)","To what extent are you able to carry out your everyday physical activities such as walking, climbing stairs, carrying groceries, or moving a chair?",
//         "How often have you been bothered by emotional problems such as feeling anxious, depressed or irritable?", "How would you rate your fatigue on average?"]
    
    let questions = ["Rate your back pain on a scale of 1-10 with zero being no pain at all and 10 being the worst pain imaginable."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 2)
        //layout.estimatedItemSize = CGSize(width: view.frame.width, height: view.frame.height / 2)
        
        let collectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! QuestionCell
        cell.questionLabel.text = questions[indexPath.row]
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

