//
//  SimpsonClass.swift
//  SimpsonBook
//
//  Created by Ersan Çetin on 23.10.2021.
//

import Foundation
import UIKit //ui image'a ulaşmak için import ettik


class SimpsonClass {
    var name : String
    var job : String
    var image : UIImage //sonuna () parantez koymuyoruz, baştan değer atamadık, sadece tür bildirdik
    
    init(name: String, job : String, image : UIImage) {
        self.name = name
        self.job = job
        self.image = image
    }
    
    //self yani classın kendisinin name'ini init'teki name'e eşitledik
        
    //initialize etmeden önce bizden 3 değişken isteyecek girilmediğinde hata döner sınıf çalışmaz
}
