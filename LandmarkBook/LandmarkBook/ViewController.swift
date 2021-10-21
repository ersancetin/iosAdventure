//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Ersan Çetin on 21.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //uitableview delegate, data source kullanmamız birinci şart

    @IBOutlet weak var tableView: UITableView!
    
    var treeImage = [UIImage]()
    var treeName = [String]()
    
    var choosenTreeName = ""
    var choosenTreeImage = UIImage()
    
    //listeleri ve değişkenleri burada tanımlıyoruz ki,her yerden erişim mümkün olsun
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //viewcontrol'ün kendisinde olacağını söylüyoruz data source ve delegate'in üçüncü şart bu
        
        treeImage.append(UIImage(named: "cinar")!)
        treeImage.append(UIImage(named: "karacam")!)
        treeImage.append(UIImage(named: "kayin")!)
        treeImage.append(UIImage(named: "kizilagac")!)
        treeImage.append(UIImage(named: "sedir")!)
        
        treeName.append(String("Çınar"))
        treeName.append(String("Karaçam"))
        treeName.append(String("Kayın"))
        treeName.append(String("Kızılağaç"))
        treeName.append(String("Sedir"))
        
        navigationItem.title = "Tree Species 🌳"
        
        //navigasyon başlığı oluşturuyor
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            treeName.remove(at: indexPath.row)
            treeImage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    //bu fonksiyon commit editingStyle indexPath nesnesi yani seçili nesneyi veriyor,
    //if ekleyip kontrol sonrasında önce indexPath.row = seçili nesnenin kaçıncı satırda olduğu
    //aynı şekilde listeden siliyoruz
    //son satır ise animasyonlu olarak tableview'den siliyoruz
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = treeName[indexPath.row]
        return cell
    }
    
    //cell yani satır değişkeni oluşturuyoruz,
    //bu değişkenin texttlabeli, sıramızın indexPath.row'una eşit, sırayla diziliyor
    //cell döndürüyoruz sonrasında
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeName.count
    }
    
    //listelerden birinin eleman sayısı kadar satır sayısı olacak diyoruz
    //döndürdüğümüz tek şey listenin eleman sayısı
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         choosenTreeName = treeName[indexPath.row]
         choosenTreeImage = treeImage[indexPath.row]
        performSegue(withIdentifier: "toImageView", sender: nil)
        
    }
    
    //bir satır seçildiğinde ne olacak diyor,
    //burada segue'yi tanımlıyoruz, toImageView sayfasına geçiş yapılacak
    //aynı zamanda seçili isimi ve image'i bir değişkene atıyoruz burada
    //bunları bir değişkene atıyoruz ki, prepare'de kullanabilelim

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageView"{
            let destinationVC = segue.destination as! ImageView
            destinationVC.selectedImage = choosenTreeImage
            destinationVC.selectedName = choosenTreeName
        }
    }
    
    //burada ise yaptığımız şey şu
    //eğer toImageView ise identifier ile kontrol ediyoruz
    //bir değişken oluşturup, bu değişkeni hedef pencereye eşitliyoruz
    //yani destinationVC = segue'nin varacağı pencere
    //bu ne demek oluyor, o penceredeki bütün objelere erişebiliyoruz,
    //ImageView içerisinde tanımladığımız değişkenlere buradan değer atıyoruz,
    //prepare for segue yani segue çalışmadan önce sayfadaki resim ve label in değerleri değişmiş oluyor
}

