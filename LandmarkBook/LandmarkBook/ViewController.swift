//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Ersan Çetin on 21.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var treeImage = [UIImage]()
    var treeName = [String]()
    
    var choosenTreeName = ""
    var choosenTreeImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            treeName.remove(at: indexPath.row)
            treeImage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = treeName[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeName.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         choosenTreeName = treeName[indexPath.row]
         choosenTreeImage = treeImage[indexPath.row]
        performSegue(withIdentifier: "toImageView", sender: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageView"{
            let destinationVC = segue.destination as! ImageView
            destinationVC.selectedImage = choosenTreeImage
            destinationVC.selectedName = choosenTreeName
        }
    }
    
}

