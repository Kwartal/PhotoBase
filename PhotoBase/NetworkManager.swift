//
//  NetworkManager.swift
//  PhotoBase
//
//  Created by Богдан Баринов on 02.09.2022.
//

import Foundation

struct NetworkManager {
    
    func loadNewImage(success:@escaping (Data) -> Void, failure:@escaping (Error?) -> Void) {
       
        DispatchQueue.global().async {
            sleep(2)
            let API = "https://picsum.photos/200/300"
            guard let apiURL = URL(string:  API) else {
                failure(nil)
                fatalError("Error")
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: apiURL) { (data, response, error) in
                guard let data = data, error == nil else {
                    failure(error)
                    return
                }
                success(data)
            }
            task.resume()
        }
    }
}
