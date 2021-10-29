//
//  CoursesNetworkManager.swift
//  Networking
//
//  Created by Alexander on 28.10.2021.
//

import Foundation
import UIKit

class CoursesNetworkManager {
    
    static let shared = CoursesNetworkManager()
    
    private init() {}
    
    func fetchCourses(completion: @escaping ([Course]) -> ()) {
        guard let url = URL(string: "https://swiftbook.ru/wp-content/uploads/api/api_courses") else { return }
        
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
}
