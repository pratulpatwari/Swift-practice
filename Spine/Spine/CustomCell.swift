//
//  CustomCell.swift
//  Spine
//
//  Created by pratul patwari on 4/3/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import Foundation
import UIKit

class CustomCell : UITableViewCell {
    
    let left : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.setTitle("L", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bilateral : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.setTitleColor(.black, for: .normal)
        button.setTitle("B", for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let disc: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 217 / 255, green: 218 / 255, blue: 230 / 255, alpha: 1)
        return v
    }()
    
    let right : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.setTitle("R", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let result: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(left)
        addSubview(bilateral)
        addSubview(disc)
        addSubview(right)
        addSubview(label)
        addSubview(result)
        
        bilateral.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        bilateral.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bilateral.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        
        disc.leftAnchor.constraint(equalTo: bilateral.leftAnchor).isActive = true
        disc.rightAnchor.constraint(equalTo: bilateral.rightAnchor).isActive = true
        disc.topAnchor.constraint(equalTo: bilateral.bottomAnchor).isActive = true
        disc.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        left.rightAnchor.constraint(equalTo: bilateral.leftAnchor, constant: 0).isActive = true
        left.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        left.widthAnchor.constraint(equalToConstant: 30).isActive = true
        left.heightAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
        
        
        right.leftAnchor.constraint(equalTo: bilateral.rightAnchor, constant: 0).isActive = true
        right.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        right.widthAnchor.constraint(equalToConstant: 30).isActive = true
        right.heightAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
        
        label.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        result.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
