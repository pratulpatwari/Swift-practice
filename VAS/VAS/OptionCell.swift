//
//  OptionCell.swift
//  VAS
//
//  Created by pratul patwari on 1/28/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scoreLabel : UILabel = {
        let label = UILabel()
        label.text = "Sample Answer" //this text will be overwritten by the text sent through service call
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let radioButton : UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        b.setTitle("radio", for: UIControl.State.normal)
        b.setImage(UIImage(named: "unchecked.png"), for: UIControl.State.normal)
        return b
    }()
    
    
    fileprivate func setupView(){
        addSubview(radioButton)
        addSubview(scoreLabel)
        
        scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        radioButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5).isActive = true
        radioButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
