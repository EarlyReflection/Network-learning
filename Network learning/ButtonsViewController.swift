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
        
        // создание url адреса с прверокй на валиднсть через guard let
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // создаем словарь для примера
        let userData = ["Course" : "Networking", "Lession" : "GET and POST requests"]
        
        // создаем экземпляр класса URLRequest
        var request = URLRequest(url: url)
        
        // определяем тип запроса
        request.httpMethod = "POST"
        
        //преобразовываем словаря в JSON формат
        guard let myJSON = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        //помещаем json в тело запроса
        request.httpBody = myJSON
        
        //создаем правило добавления новых записей, он правильно отображает наш словарь
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //создание сессии для отправки данных на сервер
        let session = URLSession.shared
        
        //вызываем у экземпляра метод dataTask c инициализатором URLRequest
        session.dataTask(with: request) { data, responce, error in
            
            //тут мы смотрим ответ от сервера
            guard let responce = responce, let data = data else { return }
            
            print(responce)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
