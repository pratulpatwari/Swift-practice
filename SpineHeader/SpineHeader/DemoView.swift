//
//  DemoView.swift
//  SpineHeader
//
//  Created by pratul patwari on 6/28/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit

class DemoView: UIView {

    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        //self.createRectangle()
        //self.createTriangle()
        
        
//        self.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: self.frame.size.height / 2, width: self.frame.size.width, height: self.frame.size.height / 16))
        
//        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: self.frame.size.height / 2, startAngle: .pi, endAngle: 0.0, clockwise: true)
        
        //complexShape()
        UIColor.orange.setFill()
        path.fill()

        
    }
    
    func complexShape() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: self.frame.size.height / 2))
//        path.addLine(to: CGPoint(x: self.frame.size.width/2 - 50.0, y: 0.0))
//        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2 - 25.0, y: 25.0),
//                    radius: 25.0,
//                    startAngle: CGFloat(180.0).toRadians(),
//                    endAngle: CGFloat(0.0).toRadians(),
//                    clockwise: false)
//        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: 0.0))
//        path.addLine(to: CGPoint(x: self.frame.size.width - 50.0, y: 0.0))
        path.addCurve(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 4),
                      controlPoint1: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height),
                      controlPoint2: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 4))
//        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
//        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        self.backgroundColor = UIColor.orange
        self.layer.mask = shapeLayer
    }
    
    func createRectangle(){
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        
        path.close()
    }
    
    func createTriangle(){
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: self.frame.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}
