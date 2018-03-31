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
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        playButton.backgroundColor = .blue
        
        view.addSubview(playButton)
        
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        self.view = view

    }
    @objc func playAction(){
        print("foi apertado")
        demoView.startTimer()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height

        demoView = DemoView(frame: CGRect(x: 0, y: 668/15,
                                                     width: 375,
                                                     height: 623.466))
        
        

        
        self.view.addSubview(demoView)
    }
    @objc func updateDemoView(){
        
        
    }


}
PlaygroundPage.current.liveView = TestViewController()

//let viewController = PrincipalViewController()
//
//PlaygroundPage.current.liveView = viewController

