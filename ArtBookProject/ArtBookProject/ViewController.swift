//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Ersan Çetin on 23.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //variables
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    var selectedArtBook = ""
    var selectedArtBookId : UUID? //optional

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //add bar button
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        getData()
        
        //fonksiyonu viewDidLoad içerisinde çağırıyoruz
        
    }
    
    //önceki sayfadan geri gelindiğinde viewWillAppear  çalışır, viewDidLoad çalışmaz bu sebeple yaşam döngüsünde burada yazdık bu fonksiyonu
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func getData(){
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        //her seferinde GetData yapacağımız için listeyi mükerrer çekiyor,
        //func başlarken listeleri temizliyoruz, üstüne tekrar çekmesin diye
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //delegator, delegate kavramlarıyla
        //burada bir uiapplication'dan shared yardımıyla obje oluşturduk,
        //onu delege ettik.
        //AppDelegate 'e cast ettik
        
        let context = appDelegate.persistentContainer.viewContext
        
        //context oluşturduk, veriyi bu context yardımıyla çekeceğiz
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArtBook")
        
        //fetchRequest tanımlıyoruz, bu fetchrequest'i bir liste olarak çekiyoruz
        
        fetchRequest.returnsObjectsAsFaults = false
        
        //bunu yaparak veri çekme işlemini biraz daha hızlandırmış olduk
        
        //do catch olmadan context.fetch yapamıyoruz,
        
        // fetch --> tut getir, yakala anlamında, fetchRequest --> çekme isteği
        
        do {
            let results = try context.fetch(fetchRequest)
            
            //uygulamanın güvenliği açısından, sonuç 0'dan büyükse for döngüsünü çalıştırmakta fayda var,
            //gelen sonuçlar 0'dan büyük değilse for döngüsünün bir anlamı olmayacaktır
            
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String{
                        self.nameArray.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                }
            }
            
            //sonuçları bir for döngüsüne soktuk if let yardımıyla sonuçlar, cast edilebilirse nameArray ve idArray listelerine ekledik
            
            self.tableView.reloadData()
            
            //reloadData diyerek tableView'in datalarını yeniliyoruz, her yeni veri eklendiğinde listeye eklenmesi için
            
        } catch {
            print("error")
        }
        
    }

    @objc func addButton(){
        //selectedArtBook'u boşa eşitledik, tableview'den gidildiğinde farklı,
        //add button üzerinden gidildiğinde farklı sonuç alınsın diye
        selectedArtBook = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtBook = nameArray[indexPath.row]
        selectedArtBookId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.choosenArtBook = selectedArtBook
            destinationVC.choosenArtBookId = selectedArtBookId
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArtBook")
            let idString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            
                            if id == idArray[indexPath.row]{
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                } catch  {
                                    print("error")
                                }
                                // break
                                
                                //sildikten sonra tekrar core data ile işlemi bitirmem gerekiyor,
                                //yani güncelleme yapılması gerek
                            }
                        }
                        
                    }
                }
            } catch {
                
            }
            
            
        }
    }
}

