//
//  Demographics.swift
//  ButtonPractice
//
//  Created by pratul patwari on 1/16/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import Foundation
import UIKit
class Demographics {
    var patientNumber: String
    var age: String
    var sex: String
    var height: String
    var blood: String
    
    init(patientNumber: String, age: String, sex: String, height: String, blood: String) {
        self.patientNumber = patientNumber
        self.age = age
        self.sex = sex
        self.height = height
        self.blood = blood
    }
}

struct Survey {
    let name: String
    let assigned: String
    let assignedDate: String
    let completedDate: String
    let completed: Bool
    let score: Int?
    
    init(name: String, assigned: String, assignedDate: String, completedDate: String, completed: Bool, score: Int?) {
        self.name=name
        self.assigned=assigned
        self.assignedDate=assignedDate
        self.completedDate=completedDate
        self.completed=completed
        self.score = score
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
