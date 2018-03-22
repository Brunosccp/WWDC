//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public class TestViewController : UIViewController {
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 130, y: 30, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        
        
        view.addSubview(label)
        self.view = view
    }
}

PlaygroundPage.current.liveView = TestViewController()

//let viewController = PrincipalViewController()
//
//PlaygroundPage.current.liveView = viewController

