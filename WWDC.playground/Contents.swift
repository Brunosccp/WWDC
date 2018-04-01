//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public class TestViewController : UIViewController {
    var squareView: UIView!
    let path1 = UIBezierPath()
    let value = UIInterfaceOrientation.landscapeLeft.rawValue
    var demoView = DemoView()
    var bpmField = UITextField()
    var compassLabel = UILabel()
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        
        //creating buttons
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let nextCompass = UIButton(frame: CGRect(x: 375 - 50, y: 0, width: 50, height: 50))
        let previousCompass = UIButton(frame: CGRect(x: 375 - 150, y: 0, width: 50, height: 50))
        
        //creating text field
        bpmField = UITextField(frame: CGRect(x: 125, y: 12.5, width: 50, height: 20))
        
        //creating labels
        compassLabel = UILabel(frame: CGRect(x: 375 - 100, y: 0, width: 50, height: 50))
        let bpmLabel = UILabel(frame: CGRect(x: 75, y: 12.5, width: 50, height: 20))
        bpmLabel.text = "Bpm:"
        bpmLabel.textAlignment = .right
        
        compassLabel.text = "\(demoView.compass+1)/\(demoView.notas.count/demoView.quantity)"
        compassLabel.textAlignment = .center
        
        
        playButton.backgroundColor = .blue
        nextCompass.backgroundColor = .black
        previousCompass.backgroundColor = .gray
        bpmField.backgroundColor = .white
        
        bpmField.keyboardType = UIKeyboardType.decimalPad
        bpmField.text = "80"
        bpmField.textAlignment = .center
        
        view.addSubview(playButton)
        view.addSubview(nextCompass)
        view.addSubview(previousCompass)
        view.addSubview(bpmField)
        view.addSubview(compassLabel)
        view.addSubview(bpmLabel)
        
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        nextCompass.addTarget(self, action: #selector(nextCompassAction), for: .touchUpInside)
        previousCompass.addTarget(self, action: #selector(previousCompassAction), for: .touchUpInside)

        
        self.view = view
    }
    
    @objc func playAction(){
        print("comecou")
        if let bpm = Double(bpmField.text!){
            demoView.startTimer(bpm: bpm)
        }else{
            bpmField.text = "80"
            demoView.startTimer(bpm: 80.0)
        }
        
    }
    @objc func nextCompassAction(){
        print("compasso++")
        //self.loadView()
        
        demoView.nextCompass()
        
        compassLabel.text = "\(demoView.compass+1)/\(demoView.notas.count/demoView.quantity)"

    }
    @objc func previousCompassAction(){
        print("compasso--")
        demoView.previousCompass()
        compassLabel.text = "\(demoView.compass+1)/\(demoView.notas.count/demoView.quantity)"
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height

        demoView = DemoView(frame: CGRect(x: 0, y: height/15,
                                                     width: width,
                                                     height: 623.466))
        
        self.view.addSubview(demoView)
    }


}
PlaygroundPage.current.liveView = TestViewController()

//let viewController = PrincipalViewController()
//
//PlaygroundPage.current.liveView = viewController

