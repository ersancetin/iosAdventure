//
//  DetailsViewController.swift
//  SimpsonBook
//
//  Created by Ersan Çetin on 23.10.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    var selectedSimpson : SimpsonClass? //optional hale getirdik
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedSimpson?.name //burada oluşturduğumuz değeri de optional yaptık
        jobLabel.text = selectedSimpson?.job
        imageView.image = selectedSimpson?.image

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
