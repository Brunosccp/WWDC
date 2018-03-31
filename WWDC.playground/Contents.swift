//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public class TestViewController : UIViewController {
    var squareView: UIView!
    let path1 = UIBezierPath()
    let value = UIInterfaceOrientation.landscapeLeft.rawValue
    var demoView = DemoView()
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        //creating buttons
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let nextCompass = UIButton(frame: CGRect(x: 375 - 50, y: 0, width: 50, height: 50))
        let previousCompass = UIButton(frame: CGRect(x: 375 - 100, y: 0, width: 50, height: 50))
        
        playButton.backgroundColor = .blue
        nextCompass.backgroundColor = .black
        previousCompass.backgroundColor = .gray
        
        view.addSubview(playButton)
        view.addSubview(nextCompass)
        view.addSubview(previousCompass)
        
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        nextCompass.addTarget(self, action: #selector(nextCompassAction), for: .touchUpInside)
        previousCompass.addTarget(self, action: #selector(previousCompassAction), for: .touchUpInside)
        
        //creating compass buttons
        
        self.view = view

    }
    @objc func playAction(){
        print("foi apertado")
        demoView.startTimer()
    }
    @objc func nextCompassAction(){
        print("compasso++")
    }
    @objc func previousCompassAction(){
        print("compasso--")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height

        demoView = DemoView(frame: CGRect(x: 0, y: height/15,
                                                     width: 375,
                                                     height: 623.466))
        
        

        
        self.view.addSubview(demoView)
    }


}
PlaygroundPage.current.liveView = TestViewController()

//let viewController = PrincipalViewController()
//
//PlaygroundPage.current.liveView = viewController

