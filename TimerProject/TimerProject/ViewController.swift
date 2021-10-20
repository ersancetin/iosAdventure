//
//  ViewController.swift
//  TimerProject
//
//  Created by Ersan Çetin on 20.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    
    //ana clas içerisinde bir timer oluşturduk
    
    var counter = 0
    
    //ana clas içerisinde bir sayaç oluşturduk
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        //her bir saniye çalışacak fonksyionu yazdık burada,
        //counter 10'dan başlayacak, her bir saniye timerFunction çalışacak
        //counter 0'a eşit olunca duracak ve time is over verecek bu fonksiyon
        //scheduled yani planlanmış bir timer'a atadık bunu
    }

    @objc func timerFunction(){
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time is over"
        }
    }

}

