//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Ersan Çetin on 23.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    
    var mySimpsons = [SimpsonClass]()
    
    //mySimpsons diye bir sınıf tanımladık, bu sınıf simpsonclass objelerini içerecek, aşağıda ise bu sınıfı dolduracağız
    //viewdidload içerisinde .append ile objeleri ekledik
    
    var choosenSimpson : SimpsonClass?
    
    //opsiyonel bıraktık, choosenSimpson, simpsonclass'ından opsiyonel bir obje olacak
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
            
        // Simpson object
    
    
        let homer = SimpsonClass(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "homer")!)
        //ui image bildirirken initialize etmemiz gerekecek, gerçekten bu değer burada demek için ! ekliyoruz

        
        let marge = SimpsonClass(name: "Marge Simpson", job: "Housewife", image: UIImage(named: "marge")!)
        
        let bart = SimpsonClass(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart")!)
        
        let lisa = SimpsonClass(name: "Lisa Simpson", job: "Student", image: UIImage(named: "lisa")!)
        
        let maggie = SimpsonClass(name: "Maggie Simpson", job: "Baby", image: UIImage(named: "maggie")!)
           
        mySimpsons.append(homer)
        mySimpsons.append(marge)
        mySimpsons.append(bart)
        mySimpsons.append(lisa)
        mySimpsons.append(maggie)
        
        //listemiz simpsonclass objelerini içeriyor,
        //yan
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenSimpson = mySimpsons[indexPath.row]
        self.performSegue(withIdentifier: "detailsVC", sender: nil)
        
    }
    
    //segue'ye hazırlan, segue'den önce çalışacak işlemler
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsVC" {
            let detailsPage = segue.destination as! DetailsViewController
            //burada gideceğimiz sayfayı bir değişken gibi tanımlıyoruz, içerisindeki her şeye erişebiliyoruz bu sayede
            detailsPage.selectedSimpson = choosenSimpson
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        
        //sadece indexpath.row 'da bıraksak bu bize bir obje verir, biz string ifade istediğimiz için objenin .name properties'ine ulaşacağız
        return cell
        
        //burada kısaca şunu söyledik, mySimpsons listesinin indexPath.row yani, bulunduğu hücrenin indeksindeki listenin elemanını yazdık, sanki bir for döngüsü gibi her satıra listenin indexPath'inci elemanını yazdırdı
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mySimpsons.count
        //mySimpsons listesinin eleman sayısı kadar row oluşacak dedik burada
    }
}

