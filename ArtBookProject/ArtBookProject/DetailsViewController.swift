//
//  DetailsViewController.swift
//  ArtBookProject
//
//  Created by Ersan Çetin on 23.10.2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{


    @IBOutlet weak var saveButton: UIButton!
    //hem action hem outlet olarak tanımladık,
    //butonu gizlemek, erişebilmek için buna ihtiyacımız var
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    //variables
    
    var choosenArtBook = ""
    var choosenArtBookId : UUID? //optional
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if choosenArtBook != ""{
            
            saveButton.isHidden = true
            
            //Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArtBook")
            let idString = choosenArtBookId?.uuidString
            
            
            fetchRequest.predicate = NSPredicate(format: "id = %@ ", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0{
                    for result in results as![NSManagedObject]{
                        
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearText.text = String(year)
                            
                            //integer ifadeyi, textfield'da göstermek için stringe çevirdik
                        }
                        
                        if let imageData = result.value(forKey: "photo") as? Data{
                            let image = UIImage(data: imageData)
                            //datamızı tekrardan ui image'a çevirdik
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("error")
            }
            
        }else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
        }
        
        
        //tapGestureRecognizer
        
        let textGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(textGesture)
        
        // interaction enabled
        
        imageView.isUserInteractionEnabled = true
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        imageView.addGestureRecognizer(imageGesture)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //bu hazır fonksiyon bizlere bir info bilgisi veriyor,
        //seçilen resime ait info, yani bilgi
        
        //kullanıcı seçtikten sonra ne olacak?
        
        imageView.image = info[.editedImage] as? UIImage
        // cast ediyoruz
        //seçili fotoğrafı imageview'in image'i olarak değiştiriyoruz. UIImage olarak benzet diyoruz,
        //kullanıcı burada çıka da bilir, hiçbir şey seçmez o sebeple soru işareti kalıyor.
        
        saveButton.isEnabled = true
        
        self.dismiss(animated: true, completion: nil)
        
        //seçim penceresi kapatılacak
        
        
    }
    
    
    @objc func showPicker(){
        
        //picker
        //picker = seçim aracı, picker'in fonksiyonları UIImagePickerControllerDelegate, UINavigationControllerDelegate mutlaka class içeririsinde inheritance edilmiş olmalı,
        //bu sayede kapatılınca ne olacak hazır fonksiyonunu kullanabiliyoruz --> didFinishPickingMediaWithInfo
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        //source type
        picker.allowsEditing = true
        // user editing
        
        present(picker, animated: true, completion: nil)
        
        //show
    }
    
    @objc func closeKeyboard(){
        view.endEditing(true)
        
        //textfield dışına basıldığında keyboard'i kapatan fonksiyon ekledik kullanıcı rahatça işlem yapsın diye
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //delegator-delegate ilişkisi gibi burada, istediğimiz işlemi yapmak için appDelegate isimli bir değişken oluşturduk, bu değişkeni AppDelegate'e cast ettik
        //segue.destination'da yaptığımız gibi burada da bir değişken oluşturup, aplikasyonun kendi delegati gibi tanımladık
        
        
        let context = appDelegate.persistentContainer.viewContext
        //appDelegate'in methodlarını kullanabiliyoruz, burada tanımlayacağımız context'te olduğu gibi
        
        //context'in içerisine ne ekleyeceğiz?
        
        let newArtBook = NSEntityDescription.insertNewObject(forEntityName: "ArtBook", into: context)
        
        //biraz önce oluşturduğum context'i kullanarak ArtBook içerisine veriyi kaydedeceğiz.
        
        newArtBook.setValue(nameText.text!, forKey: "name")
        newArtBook.setValue(artistText.text!, forKey: "artist")
        
        if let year = Int(yearText.text!){
            newArtBook.setValue(year, forKey: "year")
        }
        
        //core data'da year'i integer olarak tanımladık, kullanıcı string ifade girerse hata döner, o sebeple integer değer ise kaydet diyoruz. if let ekledik buraya
        
        newArtBook.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newArtBook.setValue(data, forKey: "photo")
        
        //context içerisinde göndereceğimiz verileri ekledik burada artık, context'i save edebiliriz
        
        do {
            try context.save()
            print("success")
        } catch {
            print("eror")
        }
        
        //context.save'i dene, eğer başarırsan success print et,
        //hata alırsan error print et dedik burada
        
        self.navigationController?.popViewController(animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        //bir öncekis sayfaya geri dönüyoruz
        
        //bildirim merkezinden bir bildirim oluşturduk, bu bildirimin adı newData,
        //viewControl içerisinden bu bildirim geldiğinde getData() fonksiyonu çalıştırılmasını sağlayacağız
        
    }
    
}
