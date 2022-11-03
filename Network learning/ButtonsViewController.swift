//
//  ButtonsViewController.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 03.11.2022.
//

import UIKit

class ButtonsViewController: UIViewController {
    
    @IBAction func getRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, responce, error in
            
            guard
                let responce = responce,
                let data = data
            else { return }
            
            print(responce)
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
        
    }
    
    @IBAction func postRequest(_ sender: Any) {
    }
    
}
