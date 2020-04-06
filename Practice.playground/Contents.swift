import UIKit


class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        let radius: Double = 1
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
        UIColor.blue.setStroke()
        path.stroke()
    }
}
let v = CircleView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
v.layer.cornerRadius = 200
v.backgroundColor = .white
