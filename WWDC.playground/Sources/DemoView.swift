import Foundation
import UIKit
import AVFoundation

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
    var quantity : Int = 4
    var inicio = true
    var notas: [(CGFloat, CGFloat, CGFloat, CGFloat)] = []
    var tempo = Timer()
    var quarter = 1
    
    var player: [AVAudioPlayer?] = []
    
    
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
            tempo = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startMusic), userInfo: nil, repeats: true)
            
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
    
    @objc func startMusic(){
        var noteCrest : CGFloat = 0
        for i in 0..<quantity{
            switch quarter {
            case 1:
                noteCrest = notas[i].0
            case 2:
                noteCrest = notas[i].1
            case 3:
                noteCrest = notas[i].2
            case 4:
                noteCrest = notas[i].3
            default:
                print("ERROR: quarter out of index")
            }
            
            //no note
            if((noteCrest <= 50 / 8) && (noteCrest >= 50 / -8)){
                print("é a nota 0")
            }else{  //theres a note
                for i in 1...7{
                    if(noteCrest >= (CGFloat(i) * 50 / 8) && noteCrest <= (CGFloat(i+1) * 50 / 8)){
                        //print("é a nota \(i)")
                        playNote(instrument: "piano", getNoteName(i) + "2")
                    }
                    else if(noteCrest <= (CGFloat(i) * 50 / -8) && noteCrest >= (CGFloat(i+1) * 50 / -8)){
                        //print("é a nota -\(i)")
                        playNote(instrument: "piano", getNoteName(i) + "1")
                    }
                }
            }
        }
        if quarter >= 4{
            quarter = 1
        }else {
            quarter += 1
        }
    
    }
    func playNote(instrument: String,_ note: String){
        let path = instrument + "/" + note
        
        guard let url = Bundle.main.url(forResource: path, withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            if (player.count >= 16){  player.remove(at: player.count-1)}
            player.insert(try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue), at: 0)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            player[0]!.play()
            //print("tamanho: \(player.count)")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func getNoteName(_ number: Int) -> String{
    switch(number){
        case 1:
            return "C"
        case 2:
            return "D"
        case 3:
            return "E"
        case 4:
            return "F"
        case 5:
            return "G"
        case 6:
            return "A"
        case 7:
            return "B"
        default:
            return "DEU RUIM"
        }
    }
    
    public func whichLine(){
        if(fingerPosition != nil){
            var linhaAtual = 0
            var tempoAtual = 0
            let waveHeight = CGFloat(50)
            
            for i in 1...quantity{
                if(fingerPosition!.y >= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) - waveHeight && fingerPosition!.y <= CGFloat(i) * self.frame.size.height / CGFloat(quantity + 1) + waveHeight){
                    linhaAtual = i
                    //print("esta é a linha \(i)")
                }
            }
            for i in 0...3{
                if(fingerPosition!.x >= CGFloat(i) * self.frame.size.width / CGFloat (4)
                    &&
                    fingerPosition!.x <= CGFloat(i+1) * self.frame.size.width / CGFloat(4) ){
                    tempoAtual = i+1
                    //print("este é o tempo \(i+1)")
                }
            }
            let height = CGFloat(linhaAtual) * (self.frame.size.height / CGFloat(quantity + 1))
            let crest = height - fingerPosition!.y
            
            //creating wave with pan
            if(linhaAtual != 0){
                linhaAtual-=1
                print("linhaAtual: \(linhaAtual), e tempoAtual: \(tempoAtual)")
                switch(tempoAtual){
                case 1:
                    notas[linhaAtual] = (crest, notas[linhaAtual].1, notas[linhaAtual].2, notas[linhaAtual].3)
                case 2:
                    notas[linhaAtual] = (notas[linhaAtual].0, crest, notas[linhaAtual].2, notas[linhaAtual].3)
                case 3:
                    notas[linhaAtual] = (notas[linhaAtual].0, notas[linhaAtual].1, crest, notas[linhaAtual].3)
                case 4:
                    notas[linhaAtual] = (notas[linhaAtual].0, notas[linhaAtual].1, notas[linhaAtual].2, crest)
                default:
                    print("Deu ruim grosso")
                }
                //print("linhaAtual: \(linhaAtual), e tempoAtual: \(tempoAtual)")
                createWave(height: height, linhaAtual, path[linhaAtual])
            }
            

            
            self.setNeedsDisplay()
        }
        
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
    public func createWave(height: CGFloat,_ linhaAtual: Int,_ path: UIBezierPath!){
        path.removeAllPoints()
        var note : CGFloat = -99
        for i in 0...3{
            switch(i){
            case 0:
                note = notas[linhaAtual].0
            case 1:
                note = notas[linhaAtual].1
            case 2:
                note = notas[linhaAtual].2
            case 3:
                note = notas[linhaAtual].3
            default:
                print("DEU RUIM FEIO")
            }
            
            //print("note: \(note)")
            let width = CGFloat(i+1) * self.frame.size.width / 5 - 40
            if(i == 0){ path.move(to: CGPoint(x: width, y: height))}
            else {path.addLine(to: CGPoint(x: width, y: height))}
            path.addCurve(to: CGPoint(x: width + 40, y: height - note),
                          controlPoint1: CGPoint(x: width + 10, y: height),
                          controlPoint2: CGPoint(x: width + 30, y: height - note))
            path.addCurve(to: CGPoint(x: width + 80, y: height),
                          controlPoint1: CGPoint(x: width + 50, y: height - note),
                          controlPoint2: CGPoint(x: width + 70, y: height))
            path.addLine(to: CGPoint(x: CGFloat(i+2) * self.frame.size.width / 5, y: height))
            path.lineWidth = 5.0
            
        }
        UIColor.purple.setStroke()
        path.stroke()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
