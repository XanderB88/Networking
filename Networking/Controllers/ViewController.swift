//
//  ViewController.swift
//  Networking
//
//  Created by Alexander on 26.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func getRequestButton(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            guard let response = response,
                  let data = data  else {
                      return
                  }
           
            print(response)
           
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
    @IBAction func postRequestButton(_ sender: UIButton) {
    }
    
}

