//
//  CustomCell.swift
//  NurseApp
//
//  Created by pratul patwari on 12/5/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import Foundation
import UIKit

struct PatientDetails {
    var name: String
    var score: String
    var steps: String
}

class PatientCell : UITableViewCell {
    
    var details : PatientDetails? {
        didSet{
            patientName.text = details?.name
            promScore.text = details?.score
            stepCount.text = details?.steps
        }
    }
    
      let dot : CircleView = {
        let circle = CircleView(frame: CGRect(x: 0, y: 12, width: 20, height: 20))
        circle.backgroundColor = .white
        return circle
    }()
    
     let patientName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
     let promScore : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
     let stepCount : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dot)
        addSubview(patientName)
        addSubview(promScore)
        addSubview(stepCount)
        
        patientName.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        patientName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        promScore.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        promScore.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stepCount.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -60).isActive = true
        stepCount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleView: UIView {
    var color = UIColor()
    override func draw(_ rect: CGRect) {
        let radius: Double = 2
        let path = UIBezierPath()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y))

        for i in stride(from: 0, to: 361.0, by: 1) {
            let radian = i * Double.pi / 180
            let x = Double(center.x) + radius * cos(radian)
            let y = Double(center.y) + radius * sin(radian)

            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.lineWidth = 5
        color.setStroke()
        path.stroke()
    }
}
