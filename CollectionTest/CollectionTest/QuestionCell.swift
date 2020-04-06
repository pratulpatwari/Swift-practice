//
//  QuestionCell.swift
//  CollectionTest
//
//  Created by pratul patwari on 1/28/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: "Georgia-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "unchecked")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupQuestion()
        //setupViews()
        setupRadio()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupQuestion(){
        addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        questionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func setupRadio(){
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 3).isActive = true
    }
    
}
