//
//  ViewController.swift
//  BasicBirthdayApp
//
//  Created by Ersan Çetin on 17.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var birthdayText: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uygulama her açıldığında, daha önce kaydedilmiş veri var mı diye buradan sorgulatıyoruz
        
        //butonun içerisinde set dedik, burada ise object olarak çağırdık
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if let newName = storedName as? String{
            nameLabel.text = newName
        }
        
        //eğer storedName'i string olarak kaydedebilirsen nameLabel textine eşitle diyoruz
        
        if let newBirthday = storedBirthday as? String{
            birthdayLabel.text = newBirthday
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func saveClicked(_ sender: Any) {
        
        UserDefaults.standard.setValue("Name: \(nameText.text!)", forKey: "name")
        UserDefaults.standard.setValue("Birthday: \(birthdayText.text!)", forKey: "birthday")
        
        nameLabel.text = "Name: \(nameText.text!)"
        birthdayLabel.text = "Birthday: \(birthdayText.text!)"
    }
    @IBAction func deleteClicked(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if (storedName as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "name")
            
            //stored name'in string'e çevrilmiş hali boş değilse çalıştır diyor "" boş bir şey nil ise bir değer bile yok demek
        }
        
        if (storedBirthday as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "birthday")
        }
    }
}

