//
//  CompletedSurveyCell.swift
//  ButtonPractice
//
//  Created by pratul patwari on 1/17/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class CompletedSurveyCell: UITableViewCell {

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
    
    let score : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 50)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let date : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dot)
        addSubview(name)
        addSubview(score)
        addSubview(date)
        
        name.leftAnchor.constraint(equalTo: dot.rightAnchor, constant: 5).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        score.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        score.leftAnchor.constraint(equalTo: name.leftAnchor).isActive = true
        score.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        date.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        date.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
