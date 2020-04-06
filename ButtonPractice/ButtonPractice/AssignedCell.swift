//
//  AssignedCell.swift
//  ButtonPractice
//
//  Created by pratul patwari on 1/17/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class AssignedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    let dot : CircleView = {
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        circle.backgroundColor = .white
        return circle
    }()
    
    let name : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let assignLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.textColor = UIColor.init(red: 91 / 255, green: 151 / 255, blue: 255 / 255, alpha: 1)
        lbl.text = "Survey Assigned by"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var assignName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.textColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dot)
        addSubview(name)
        addSubview(assignLabel)
        addSubview(assignName)
        
        name.leftAnchor.constraint(equalTo: dot.rightAnchor, constant: 5).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        assignLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        assignLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        assignLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        assignName.topAnchor.constraint(equalTo: assignLabel.bottomAnchor, constant: 1).isActive = true
        assignName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        assignName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
