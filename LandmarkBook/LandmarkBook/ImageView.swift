//
//  ImageView.swift
//  LandmarkBook
//
//  Created by Ersan Çetin on 21.10.2021.
//

import UIKit

class ImageView: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var landmarkLabel: UILabel!
    
    var selectedImage = UIImage()
    var selectedName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage
        landmarkLabel.text = selectedName

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
