//
//  NetworkManager.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 06.11.2022.
//

import UIKit

class NetworkManager {
    
    static func getRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
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
    
    
    static func postRequest(url: String) {
        
        // создание url адреса с прверокй на валиднсть через guard let
        guard let url = URL(string: url) else { return }
        
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
    
    static func downloadImage(url: String, completition: @escaping (_ image: UIImage)->Void) {
        // создание url адреса с прверокй на валиднсть через guard let
        guard let url = URL(string: url) else { return }
        
        //создаем экземпляр URLsession
        let session = URLSession.shared
        
        //вызываем у экземпляра метод dataTask with completionHandler, метод создает задачу на получение содержмого по указанному адресу и возвращает его в completionHandler
        session.dataTask(with: url) { data, responce, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                   completition(image)
                }
            }
        }.resume()
    }
    
    static func fetchData(url: String, completition: @escaping (_ course: [Course])->Void) {
      
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                completition(courses)
            } catch let error{
                print("Error serialisation json", error)
            }
        }.resume()
    }
    
}
