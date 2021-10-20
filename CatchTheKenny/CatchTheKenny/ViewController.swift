//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Ersan Çetin on 20.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //views

    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image4View: UIImageView!
    @IBOutlet weak var image5View: UIImageView!
    @IBOutlet weak var image6View: UIImageView!
    @IBOutlet weak var image7View: UIImageView!
    @IBOutlet weak var image8View: UIImageView!
    @IBOutlet weak var image9View: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    //variables
    
    var score = 0
    
    var counter = 0
    
    var highScore = 0
    
    var timer = Timer()
    
    var kennyTimer = Timer()
    
    var kennyArray = [UIImageView] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let storedHighScore = UserDefaults.standard.object(forKey: "highh")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        counter = 10
        
        timeLabel.text = "\(counter)"
        
        scoreLabel.text = "Score: \(score)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        //images
        
        image1View.isUserInteractionEnabled = true
        image2View.isUserInteractionEnabled = true
        image3View.isUserInteractionEnabled = true
        image4View.isUserInteractionEnabled = true
        image5View.isUserInteractionEnabled = true
        image6View.isUserInteractionEnabled = true
        image7View.isUserInteractionEnabled = true
        image8View.isUserInteractionEnabled = true
        image9View.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(changeKenny))
        
        image1View.addGestureRecognizer(recognizer1)
        image2View.addGestureRecognizer(recognizer2)
        image3View.addGestureRecognizer(recognizer3)
        image4View.addGestureRecognizer(recognizer4)
        image5View.addGestureRecognizer(recognizer5)
        image6View.addGestureRecognizer(recognizer6)
        image7View.addGestureRecognizer(recognizer7)
        image8View.addGestureRecognizer(recognizer8)
        image9View.addGestureRecognizer(recognizer9)
        
        //farklı gesture recognizerlar oluştursak da hepsini aynı fonksiyona yani changeKenny fonksiyonuna bağladığımız için her birine dokunulduğunda score artacaktır
        
        kennyArray = [image1View, image2View, image3View, image4View, image5View, image6View, image7View, image8View, image9View]
        
        hideKenny()
        
        
    }
    
    
    @objc func hideKenny(){
        for i in kennyArray{
            i.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        
        //burada random bir integer oluşturduk ve o random integeri listenin elemanı üzerinden görünümünü false yaptık
        
        kennyArray[random].isHidden = false
        
        //bunu şu şekilde de yapabilirdik ama elementlerin randomunu seçeceği için daha fazla kasma durumu olacaktır
        // kennyArray.randomElement()
        
    }
    
    @objc func changeKenny(){
        score += 1
        
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func timerFunction(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0{
            timer.invalidate()
            kennyTimer.invalidate()
            
            for i in kennyArray{
                i.isHidden = true
            }
            
            //bütün kennyler görünmez hale geliyor böylece
            
            //highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highh")
            }
            
            
            //alert
            
            let alert = UIAlertController(title: "🤡 Time is over", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                
                //replay function
                
                //score'u sıfırladık label'a koyduk
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                //butonun içerisinde başka bir değişken olmadığını anlasın diye self. koyarak yukarıda tanımladığımız nesneler olduğunu belirtiyoruz
                //butonun içinde aynı isimde başka bir değişken de tanımlayabilirdik böyle bir şey yapmamalıyız
                //swift bize yine de soracak self. diye belirtmemiz gerekiyor
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                

                
            }
            
            alert.addAction(cancelButton)
            alert.addAction(replayButton)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}

