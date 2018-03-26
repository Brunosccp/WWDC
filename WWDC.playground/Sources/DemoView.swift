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
    
    var paths: [UIBezierPath]! = []
    var path: UIBezierPath!
    var path2: UIBezierPath!
    var path3: UIBezierPath!
    var path4: UIBezierPath!
    
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
        self.createAllLines(4)
        //self.createWave()
        
        // Specify the fill color and apply it to the path.
    }
    public func createRectangle() {
        // Initialize the path.
        path = UIBezierPath()

        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: self.frame.size.height/2))

        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height/2))
        path.lineWidth = 5.0
    }
    public func createCircle(){
        path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2,
                                           y: 0.0,
                                           width: self.frame.size.height,
                                           height: self.frame.size.height))
    }
    public func createArc(){
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
            radius: self.frame.size.height/2,
            startAngle: CGFloat(180).toRadians(),
            endAngle: CGFloat(0).toRadians(),
            clockwise: true)
    }
    public func createAllLines(_ quantity : Int){
        switch quantity {
        case 1:
            path = UIBezierPath()
            
            self.createLine(height: self.frame.size.height / 2, path)
            break
        case 2:
            path = UIBezierPath()
            path2 = UIBezierPath()
            
            self.createLine(height: self.frame.size.height / 3, path)
            self.createLine(height: 2 * self.frame.size.height / 3, path2)
        case 3:
            path = UIBezierPath()
            path2 = UIBezierPath()
            path3 = UIBezierPath()
            
            self.createLine(height: self.frame.size.height / 4, path)
            self.createLine(height: 2 * self.frame.size.height / 4, path2)
            self.createLine(height: 3 * self.frame.size.height / 4, path3)
        case 4:
            path = UIBezierPath()
            path2 = UIBezierPath()
            path3 = UIBezierPath()
            path4 = UIBezierPath()
            
            self.createLine(height: self.frame.size.height / 5, path)
            self.createLine(height: 2 * self.frame.size.height / 5, path2)
            self.createLine(height: 3 * self.frame.size.height / 5, path3)
            self.createLine(height: 4 * self.frame.size.height / 5, path4)
        default:
            return
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
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addCurve(to: CGPoint(x: 50, y: self.frame.size.height - 30),
                      controlPoint1: CGPoint(x: 15, y: self.frame.size.height),
                      controlPoint2: CGPoint(x: 35, y: self.frame.size.height - 30))
        path.addCurve(to: CGPoint(x: 100, y: self.frame.size.height),
                      controlPoint1: CGPoint(x: 65, y: self.frame.size.height - 30),
                      controlPoint2: CGPoint(x: 85, y: self.frame.size.height))
        path.lineWidth = 5.0
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
