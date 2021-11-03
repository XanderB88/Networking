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
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Course].self) { response in
            
            switch response.result {
                case .success(let courses):
                    completion(courses)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
