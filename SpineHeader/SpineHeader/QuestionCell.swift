//
//  QuestionCell.swift
//  SpineHeader
//
//  Created by pratul patwari on 4/8/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import Foundation
import UIKit

class QuestionCell: UITableViewCell {
    
    let question: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let button: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(question)
        addSubview(button)
        addSubview(label)
        
        question.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        question.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        button.leftAnchor.constraint(equalTo: question.rightAnchor, constant: 20).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 1).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
