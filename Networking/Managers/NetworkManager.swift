//
//  CoursesNetworkManager.swift
//  Networking
//
//  Created by Alexander on 28.10.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCourses(withURL url: String, completion: @escaping ([Course]) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data else { return }
            
            do  {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                
                completion(courses)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func downloadImage(withURL url: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
}
