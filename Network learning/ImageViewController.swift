//
//  ViewController.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 03.11.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let url = "https://media.idownloadblog.com/wp-content/uploads/2021/09/Light_Beams_Blue_Light-iPhone-13-Pro-official-apple-wallpaper-768x1661.jpg"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { image in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }

    }
}

