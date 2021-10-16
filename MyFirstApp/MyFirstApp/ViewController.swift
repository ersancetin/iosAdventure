//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Ersan Çetin on 16.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myErsan: UILabel!
    @IBOutlet weak var ersanPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeClicked(_ sender: Any) {
        ersanPic.image = UIImage(named: "IMG_20181015_125907")
        
        
    }
}

