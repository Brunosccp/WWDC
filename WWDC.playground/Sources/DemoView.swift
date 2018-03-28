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
    var inicio = true
    var notas: [(Int, Int, Int, Int)] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    
        for _ in 1...quantity{
            notas.append((0, 0, 0, 0))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override func draw(_ rect: CGRect) {
        self.createAllLines(quantity)
        self.timeLines()
        
        if(inicio == true){
            createGestureRecognizerPan()
            inicio = false
        }
        
        // Specify the fill color and apply it to the path.
    }
    func createGestureRecognizerPan(){
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
        }
        if sender.state == UIGestureRecognizerState.changed{
            //print("posicao: \(sender.location(in: self))")
            fingerPosition = sender.location(in: self)
            whichLine()
        }
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
            var linhaAtual = 0
            
            for i in 1...quantity{
                if(fingerPosition!.y >= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) - 30 && fingerPosition!.y <= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) + 30){
                    linhaAtual = i
                    //print("esta é a linha \(i)")
                }
            }
            
            
            if(linhaAtual != 0){
                let height = CGFloat(linhaAtual) * (self.frame.size.height / CGFloat(quantity + 1))
                createWave(height: height, crest: height - fingerPosition!.y, path[linhaAtual-1])
            }
            
            
            
            //createLine(height: 40, path[linhaAtual-1])
            
//            var path2 = path[linhaAtual-1]
//            path2.removeAllPoints()
//            path2 = UIBezierPath()
//            path2.move(to: CGPoint(x: 0.0, y: 40))
//            path2.addLine(to: CGPoint(x: self.frame.size.width, y: 40))
//            path2.lineWidth = 5.0
            
            
            
            self.setNeedsDisplay()
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
            //path.
        }
        for i in 1...quantity{
            self.createLine(height: CGFloat(i) * (self.frame.size.height / CGFloat(quantity + 1)), path[i - 1])
        }
        
    }
    public func createLine(height : CGFloat,_ path: UIBezierPath!){
        //path = nil
        path.move(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: height))
        path.lineWidth = 5.0
        
        UIColor.purple.setStroke()
        path.stroke()
    }
    public func timeLines(){
        let timeLines = UIBezierPath()
        for i in 1...4{
            timeLines.move(to: CGPoint(x: CGFloat(i) * self.frame.size.width / 5, y: 0))
            timeLines.addLine(to: CGPoint(x: CGFloat(i) * self.frame.size.width / 5, y: self.frame.size.height))
            timeLines.lineWidth = 1.0
        }
        
        UIColor.black.setStroke()
        timeLines.stroke()
    }
    public func createWave(height: CGFloat, crest: CGFloat ,_ path: UIBezierPath!){
        path.removeAllPoints()
        let width = 1 * self.frame.size.width / 5 - 50
        
        path.move(to: CGPoint(x: width, y: height))
        path.addCurve(to: CGPoint(x: width + 50, y: height - crest),
                      controlPoint1: CGPoint(x: width + 15, y: height),
                      controlPoint2: CGPoint(x: width + 35, y: height - crest))
        path.addCurve(to: CGPoint(x: width + 100, y: height),
                      controlPoint1: CGPoint(x: width + 65, y: height - crest),
                      controlPoint2: CGPoint(x: width + 85, y: height))
        path.addLine(to: CGPoint(x:self.frame.size.width, y: height))
        path.lineWidth = 5.0
        
        UIColor.purple.setStroke()
        path.stroke()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
