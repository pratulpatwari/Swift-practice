//
//  DisabilityCell.swift
//  NurseApp
//
//  Created by pratul patwari on 12/10/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class DisabilityCell : UITableViewCell {
    
    var checked : Bool = false
    
    let disability : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let checkbox : UIImageView = {
        let imgView = UIImageView()
        let img = UIImage(named: "unchecked.png")
        imgView.image = img
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(disability)
        addSubview(checkbox)
        
        
        disability.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        disability.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        checkbox.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        checkbox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkbox.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
