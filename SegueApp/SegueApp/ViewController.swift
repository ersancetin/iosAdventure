//
//  ViewController.swift
//  SegueApp
//
//  Created by Ersan Çetin on 18.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var userName = ""
    
    //önce boş bir değer olarak tanımladık, tüm fonksiyonlardan erişmek için
    //clicked yapıldığında değeri eşitledik
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextButton(_ sender: Any) {
        userName = textField.text ?? ""
        performSegue(withIdentifier: "NextControllerSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextControllerSegue"{
            let destinationVC = segue.destination as? SecondViewController
            //cast işlemi gerçekleştiriyoruz burada
            //view controller veriyor ama hangisini verdiğini bilmiyor
            //o sebeple burada secondview controller'a cast ediyoruz
            destinationVC?.myName = "Hi, \(userName) 🤟"
            
            //destinationVC isimli değişken aslında bizim ikinci sayfamız,
            //buradaki tüm değişkenlere de ulaşıyoruz,
            //myName'i userName'e eşitliyoruz
            
            //adı üstünde prepare for segue olduğu için,
            //segue çalışmadan hemen önce gerçekleştirilecek işlemler
            //bu sayede kullanıcı diğer sayfaya geçmeden önce bu eşitleme gerçekleşmiş oluyor
        }
    }
}

