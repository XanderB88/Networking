//
//  AlamofireNetworkingManager.swift
//  Networking
//
//  Created by Alexander on 03.11.2021.
//

import Foundation
import Alamofire

class AlamofireNetworkingManager {
    
    static let shared = AlamofireNetworkingManager()
    
    private init() {}
    
    func fetchCourses(withURL url: String, completion: @escaping ([Course]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().response { responseData in
           
            guard let data = responseData.data else { return }
            
            do  {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                
                completion(courses)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
}
