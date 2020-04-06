//
//  ViewController.swift
//  CollectionTest
//
//  Created by pratul patwari on 1/27/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let questions = ["In general, would you say your health is:","In general, would you say your quality of life is:."
        ,"In general, how would you rate your physical health?", "In general, how would you rate your mental health, including your mood and your ability to think?",
         "In general, how would you rate your satisfaction with your social activities and relationships?",
         "In general, please rate how well you carry out your usual social activities and roles. (This includes activities at home, at work and in your community, and responsibilities as a parent, child, spouse, employee, friend, etc.)","To what extent are you able to carry out your everyday physical activities such as walking, climbing stairs, carrying groceries, or moving a chair?",
         "How often have you been bothered by emotional problems such as feeling anxious, depressed or irritable?", "How would you rate your fatigue on average?"]

    var option: [IndexPath] = []
    let number = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: (view.frame.width / CGFloat(number)), height: 50)
        layout.minimumInteritemSpacing = 0
        
        let collectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        view.addSubview(collectionView)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! QuestionCell
        if number > 5 {
            cell.questionLabel.text = String(indexPath.item)
        } else {
            cell.questionLabel.text = String(indexPath.item + 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! QuestionCell
        
        if option.count > 0 {
            option.forEach { (index) in
                let cell = collectionView.cellForItem(at: index) as! QuestionCell
                cell.imageView.image = #imageLiteral(resourceName: "unchecked")
                
            }
            option.removeAll()
        }
        cell.imageView.image = #imageLiteral(resourceName: "checked")
        option.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: option[0]) as! QuestionCell
        cell.imageView.image = #imageLiteral(resourceName: "unchecked")
        option.removeAll()
        return true
    }
    
}

