//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Ersan Çetin on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isErsanBir = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // bir jest algılayıcım olsun, görsele tıklandığında görsel ve labeldeki isim değişsin
        // öncelikle görselin tıklanabilir olması lazım
        
        imageView.isUserInteractionEnabled = true //kullanıcı üzerine tıklayabilsini etkinleştirdik
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        imageView.addGestureRecognizer(gestureRecognizer) //imageview'a gesture recognizer ekledik bu sayede
        
        //target'imiz view controller'in kendisi olacak yani self diyoruz,
        //action ise bizden bir selektör istiyor,
        //burada objective c kullanıyoruz ama fonksyonun başına @objc eklememiz yeterli oluyor, hiçbir farkı yok swift kodundan
        
    }

    @objc func changePic(){
        
        //bir boolean değişkeni oluşturduk,
        //bu değişkene her tıklandığında boolean değeri değişecek ve buna göre fotoğraf ve label değişecek,
        //değişkeni fonksiyon içerisinde oluşturursak fotoğrafa her tıklandığında otomatik olarak true değeri atar,
        //bu da istediğimizi elde etmemize olanak sağlamaz. dolayısıyla değişkeni fonksiyon dışına tanımlamalıyız
        
        //isErsanBir'in değeri nerede olduğumuza göre kendiliğinden belirlenecek artık
        
        if isErsanBir == true{
            imageView.image = UIImage(named: "ersan2")
            nameLabel.text = "ersanın fotoğraf 2"
            isErsanBir = false
        }else{
            imageView.image = UIImage(named: "ersan1")
            nameLabel.text = "ersanın fotoğraf 1"
            isErsanBir = true
        }
       
        
        //1 jest algılayıcı oluşturduk
        //2 bu jest algılayıcıyı görselimize ekleyeceğiz
        //3 görselimize tıklandığında resim ve label değişecek
        
    }

}

