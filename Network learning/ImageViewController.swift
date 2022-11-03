//
//  ViewController.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 03.11.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    enum Link: String {
        case firstImage = "https://images.unsplash.com/photo-1567980475192-bb52b1a18795?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=927&q=80"
        case secondImage = "https://media.idownloadblog.com/wp-content/uploads/2021/09/Light_Beams_Blue_Light-iPhone-13-Pro-official-apple-wallpaper-768x1661.jpg"
    }
    
    
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
        
        
        // создание url адреса с прверокй на валиднсть через guard let
        guard let url = URL(string: Link.secondImage.rawValue) else { return }
        
        //создаем экземпляр URLsession
        let session = URLSession.shared
        
        //вызываем у экземпляра метод dataTask with completionHandler, метод создает задачу на получение содержмого по указанному адресу и возвращает его в completionHandler
        session.dataTask(with: url) { data, responce, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}

