//
//  ViewController.swift
//  PlacesBook
//
//  Created by Ersan Çetin on 28.10.2021.
//

import UIKit
import MapKit
import CoreData
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var commentText: UITextField!
        
    @IBOutlet weak var locationLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    //general coordinates longtitude-lattitude
    
    var choosenLattitude = Double()
    var choosenLongtitude = Double()
    
    var label = "choose best location"
    var annotationName = ""
    var annotationComment = ""
    var annotationLongtitude = Double()
    var annotationLattitude = Double()
    var selectedUUID : UUID?
    var selectedName = ""
        
    //değişken olarak viewdidload üzerine tanımlamamız gerekiyor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationLabel.text = label
        
        mapView.delegate = self
        
        nameText.text = annotationName
        commentText.text = annotationComment
                
        
        //location
        
        //bir lokasyon oluşturduk, şuanlık konumumuz
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //pil tüketimi çok yüksek olur
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tapLocation(gestureRecognizer: )))
        
        //fonksiyonu parametreli olarak atıyoruz, parametremiz ise bizden bir gesture recognizer istiyor
        
        mapView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.minimumPressDuration = 2
        
        
        if selectedName != "" { //conditions'i uuid üzerinden sağlayamayız çünkü optional, hata verir
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            
            let idString = selectedUUID?.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as![NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String{
                            annotationName = name
                            
                            if let comment = result.value(forKey: "comment") as? String{
                                annotationComment = comment
                                
                                if let lattitude = result.value(forKey: "lattitude") as? Double{
                                    annotationLattitude = lattitude
                                   
                                    if let longtitude = result.value(forKey: "longtitude") as? Double{
                                        annotationLongtitude = longtitude
                                        
                                        let annotation = MKPointAnnotation()
                                        
                                        annotation.title = annotationName
                                        annotation.subtitle = annotationComment
                                                                                    
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLattitude, longitude: annotationLongtitude) //lokasyon belirledik
                                        annotation.coordinate = coordinate
                                        mapView.addAnnotation(annotation)
                                       
                                        
                                        nameText.text = annotationName
                                        commentText.text = annotationComment
                                        
                                        //kullanıcı her hareket ettiğinde konumu güncelle dediğimiz için öncelikle kulllanıcıdan konum aldırmayı durdurduk, sonrasında ise span ve region oluşturup pin'e zoomladık
                                        
                                        locationManager.stopUpdatingLocation()
                                        
                                        //zoom --> annototation
                                        
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) //yakınlık uzaklık seviyesi belirliyoruz
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        
                                        mapView.setRegion(region, animated: true)

                                        
                                    }
                                }
                            }
                        }
                    
                    }
                }
            } catch  {
                
            }
            
        }else{
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if selectedName == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude) //lokasyon belirledik
        
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) //yakınlık uzaklık seviyesi belirliyoruz
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    @objc func tapLocation(gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began { //ui long press yapıldıysa
           
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchedCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            
            //first we need touch point, after we convert to point--> coordinate
            
            choosenLattitude = touchedCoordinates.latitude
            choosenLongtitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation() //mkpointannotation sınıfından bir nesne oluşturduk objemiz mkpointannotation, nesne --> annotation
            
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            
            self.mapView.addAnnotation(annotation)
            
        }
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "name")
        newPlace.setValue(commentText.text, forKey: "comment")
        newPlace.setValue(choosenLongtitude, forKey: "longtitude")
        newPlace.setValue(choosenLattitude, forKey: "lattitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
            self.navigationController?.popViewController(animated: true)
            print("success") 
        } catch {
            print("core data saving error")
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //annotation görünümünü özelleştiriyoruz
        
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true //detay
            pinView?.tintColor = UIColor.black
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button //sağ tarafında göster diyoruz
        }else{
            pinView?.annotation = annotation
        }
        
        
        return pinView
    }
    
    //oluşturduğumuz pin'in yanındaki butona tıklandıysa ne olacağını söyleyen fonksiyon
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedName != ""{
            let requestLocation = CLLocation(latitude: annotationLattitude, longitude: annotationLongtitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placesmark, error) in
                //closure yapısında yazdık bu işlemleri
               
                if let placemark = placesmark{ //optional mı değil mi kontrolü geçtik bu sayede
                    if placemark.count > 0{
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        
                        item.name = self.annotationName
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                        
                        //navigasyonu açabilmek için bir map item oluşturmamız gerekiyor
                        //bu map item içerisinde hangi options'da açacağımızı belirtmemiz gerekiyor
                        //map item için de placemark denilen bir objeye ihtiyaç duyuyoruz bu objeyi de reverseGeocodeLocation dediğimiz methodla alıyoruz
                    }
                }
               
            }
        }
    }
    
}

