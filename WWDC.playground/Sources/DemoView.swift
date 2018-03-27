import Foundation
import UIKit

public class DemoView: UIView{
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    var path: [UIBezierPath]! = []
    var fingerPosition: CGPoint?
    var quantity : Int = 6
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override func draw(_ rect: CGRect) {
        
        //self.createRectangle()
        //self.createCircle()
        //self.createArc()
        self.createAllLines(quantity)
        //self.createWave()
        
        // Specify the fill color and apply it to the path.
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            fingerPosition = CGPoint(x: position.x, y: position.y)
        }
        whichLine()
        
    }
    public func whichLine(){
        if(fingerPosition != nil){
            print("fingerPosition: \(fingerPosition)")
            for i in 1...quantity{
                if(fingerPosition!.y >= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) - 30 && fingerPosition!.y <= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) + 30){
                    print("esta é a linha \(i)")
                }
            }
        }
    }
    
    public func createRectangle() {
        // Initialize the path.
        path[0] = UIBezierPath()

        // Specify the point that the path should start get drawn.
        path[0].move(to: CGPoint(x: 0.0, y: self.frame.size.height/2))

        // Create a line between the starting point and the bottom-left side of the view.
        path[0].addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height/2))
        path[0].lineWidth = 5.0
    }
    public func createCircle(){
        path[0] = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2,
                                           y: 0.0,
                                           width: self.frame.size.height,
                                           height: self.frame.size.height))
    }
    public func createArc(){
        path[0] = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
            radius: self.frame.size.height/2,
            startAngle: CGFloat(180).toRadians(),
            endAngle: CGFloat(0).toRadians(),
            clockwise: true)
    }
    public func createAllLines(_ quantity : Int){
        for _ in 1...quantity{
            path.append(UIBezierPath())
        }
        for i in 1...quantity{
            self.createLine(height: CGFloat(i) * (self.frame.size.height / CGFloat(quantity + 1)), path[i - 1])
        }
        
    }
    public func createLine(height : CGFloat,_ path: UIBezierPath!){
        path.move(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: height))
        path.lineWidth = 5.0
        
        UIColor.purple.setStroke()
        path.stroke()
    }
    public func createWave(){
        path[0] = UIBezierPath()
        path[0].move(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path[0].addCurve(to: CGPoint(x: 50, y: self.frame.size.height - 30),
                      controlPoint1: CGPoint(x: 15, y: self.frame.size.height),
                      controlPoint2: CGPoint(x: 35, y: self.frame.size.height - 30))
        path[0].addCurve(to: CGPoint(x: 100, y: self.frame.size.height),
                      controlPoint1: CGPoint(x: 65, y: self.frame.size.height - 30),
                      controlPoint2: CGPoint(x: 85, y: self.frame.size.height))
        path[0].lineWidth = 5.0
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
