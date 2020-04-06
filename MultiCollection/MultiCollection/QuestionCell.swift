//
//  QuestionCell.swift
//  MultiCollection
//
//  Created by pratul patwari on 1/28/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var option: [IndexPath] = []
    let number = 11
    var collectionView: UICollectionView!
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: "Georgia-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var optionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Pain"
        label.font = UIFont.init(name: "Georgia-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Height: ", frame.height)
        setupQuestion()
        setupOptionLabel()
        options()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupOptionLabel(){
        addSubview(optionLabel)
        
    
        optionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40).isActive = true
        optionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    fileprivate func options(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: (self.frame.width / CGFloat(number)), height: 50)
        layout.minimumInteritemSpacing = 0
        
        //let collectionView:UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.frame = self.frame
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OptionsCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: optionLabel.bottomAnchor, constant: 40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    fileprivate func setupQuestion(){
        addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        questionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! OptionsCell
        cell.imageView.image = #imageLiteral(resourceName: "unchecked")
        
        if number > 5 {
            cell.optionValue.text = String(indexPath.item)
        } else {
            cell.optionValue.text = String(indexPath.item + 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OptionsCell
        if option.count > 0 {
            option.forEach { (index) in
                let cell = collectionView.cellForItem(at: index) as! OptionsCell
                cell.imageView.image = #imageLiteral(resourceName: "unchecked")
            }
            option.removeAll()
        }
        cell.imageView.image = #imageLiteral(resourceName: "checked")
        option.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
