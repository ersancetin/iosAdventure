//
//  ViewController.swift
//  AlertProject
//
//  Created by Ersan Çetin on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var password2Text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
       /*
        if usernameText.text == "" {
            let alert = UIAlertController(title: "Error", message: "Username not found", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }else if passwordText.text == "" {
            let alert = UIAlertController(title: "Error", message: "Password not found", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }else if passwordText.text != password2Text.text {
            let alert = UIAlertController(title: "Error", message: "Passwords do not match ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Welcome", message: "Your welcome, Ersan 🤟", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
         */
        
        //bunu bu şekilde yazmak sürekli kodu tekrar etmek yerine bir fonksiyon içerisinde bu kodu yazmaya çalışacağız
        
        if usernameText.text == "" {
            alert(title: "Error", message: "Username not found", buttonTitle: "OK")
        }else if passwordText.text == ""{
            alert(title: "Error", message: "Password not found", buttonTitle: "OK")
        }else if passwordText.text != password2Text.text{
            alert(title: "Error", message: "Passwords do not match", buttonTitle: "OK")
        }else{
            alert(title: "Welcome", message: "Your Welcome \(usernameText.text ?? "" ) 🤟", buttonTitle: "OK")
        }

       
        /*
         
        let alert = UIAlertController(title: "Error", message: "Username not found", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        
         */
        
        //self, view controller'a referans veriyordu
        //self.present bir şeyi göster anlamına geliyor aslında
        //gösterilmesini istediğimiz şey "alert", alert'i self.present içine ekliyoruz
        
        //self.present 'den önce bir buton koyuyoruz, buton olmazsa alert kapanmaz bir halde geliyor
        //göstermeden önce bir butonu da ekletiyoruz let alertin altına
        
        //default stilinde ok'a basınca otomatik olarak kapatıyor. handler butona basınca bir şey yapılsın istiyor muyuz bu anlama geliyor. biz bir şey yapılsın istemiyoruz o sebeple nil bırakıyoruz.
        
        //alert diyoruz methodlarına bakıyoruz, addAction diyip okButton'u içine ekliyoruz alertin
        
    }
    
    func alert(title : String, message: String, buttonTitle: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        //sürekli yaptığımız işlemleri bir fonksiyona indirgedik,
        //fonksiyon içinde de kullandığımız değişkenleri parametre olarak ekledik ve if bloğu içerisinde sadece parametre değerlerini girerek kodumuzu oldukça kısalttık
    }
}

