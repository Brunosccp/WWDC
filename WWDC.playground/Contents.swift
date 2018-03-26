//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public class TestViewController : UIViewController {
    var squareView: UIView!
    let path1 = UIBezierPath()
    let value = UIInterfaceOrientation.landscapeLeft.rawValue
    
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        let label = UILabel()
        label.frame = CGRect(x: 130, y: 30, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        
        view.addSubview(label)
        self.view = view
        
        
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height - self.view.frame.size.height/15
        let demoView = DemoView(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height/15,
                                              width: width,
                                              height: height))
        
        self.view.addSubview(demoView)
    }
}
PlaygroundPage.current.liveView = TestViewController()

//let viewController = PrincipalViewController()
//
//PlaygroundPage.current.liveView = viewController

