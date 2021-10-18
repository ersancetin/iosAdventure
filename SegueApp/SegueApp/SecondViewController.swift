//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Ersan Çetin on 18.10.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = myName
    }

}
