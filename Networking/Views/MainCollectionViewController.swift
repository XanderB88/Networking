//
//  MainCollectionViewController.swift
//  Networking
//
//  Created by Alexander on 31.10.2021.
//

import UIKit

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case courses = "Courses"
    case downloadFiles = "Download Files"
}

private let reuseIdentifier = "ActionCell"
private let url = "https://jsonplaceholder.typicode.com/posts"

class MainCollectionViewController: UICollectionViewController {
    
    let actions = Actions.allCases
     
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        
        cell.actionLabel.text = actions[indexPath.row].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
            case .downloadImage:
                performSegue(withIdentifier: "showImage", sender: self)
            case .get:
                NetworkManager.shared.getRequest(withUrl: url)
            case .post:
                NetworkManager.shared.postRequest(withURL: url)
            case .courses:
                performSegue(withIdentifier: "showCourses", sender: self)
            case .downloadFiles:
                print(action.rawValue)
        }
    }
}
