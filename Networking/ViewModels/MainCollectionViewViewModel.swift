//
//  MainCollectionViewViewModel.swift
//  Networking
//
//  Created by Alexander on 02.11.2021.
//

import Foundation

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case courses = "Courses"
    case downloadFiles = "Download Files"
    case coursesAlamofire = "Courses (Alamofire)"
}

class MainCollectionViewViewModel: MainCollectionViewViewModelProtocol {
    
    
    let actions = Actions.allCases
    
    func numberOfItems() -> Int {
        return actions.count
    }
    
    func getAction(withIndexPath indexPath: IndexPath) -> Actions {
        return actions[indexPath.row]
    }
    
    func cellViewModel(withIndexPath indexPath: IndexPath) -> MainCollectionViewCellViewModelProtocol? {
        let action = actions[indexPath.row]
        return MainCollectionViewCellViewModel(action: action)
    }
}
