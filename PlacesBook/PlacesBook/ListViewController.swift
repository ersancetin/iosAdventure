//
//  ListViewController.swift
//  PlacesBook
//
//  Created by Ersan Çetin on 29.10.2021.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    
    //variables
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    var choosenPlaceId : UUID?
    var choosenPlace = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //fetchRequest
        
        getData()

    }
   
    @objc func getData(){
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        fetchRequest.returnsObjectsAsFaults = false //for fetch request speed
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    idArray.append(id)
                }
            }
            print("success fetch request")
        } catch {
            print("fetch request error")
        }
        
        self.tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenPlaceId = idArray[indexPath.row]
        choosenPlace = nameArray[indexPath.row]
        performSegue(withIdentifier: "cellToMapViewController", sender: nil)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellToMapViewController"{
            let destinationVC = segue.destination as! ViewController
            destinationVC.selectedUUID = choosenPlaceId
            destinationVC.selectedName = choosenPlace
            destinationVC.label = choosenPlace
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row] //indexpath değerini, name array dizisinin elemanlarına eşledik
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    @objc func clickAddButton(){
        performSegue(withIdentifier: "toMapViewController", sender: nil)
    }
    
    
    

}
