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
    
    //öncelikle burada değişkenleri tanımlıyoruz
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage
        landmarkLabel.text = selectedName
        
        //burada ise tanımladığımız değişkenleri, imageview'in image'ine
        //label'in text'ine atıyoruz
        
        //diğer sayfadaki prepare for segue sayesinde otomatik olarak dönmüş oluyor değişkenler


        
    }

}
