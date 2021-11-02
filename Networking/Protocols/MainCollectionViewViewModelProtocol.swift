//
//  MainCollectionViewViewModelProtocol.swift
//  Networking
//
//  Created by Alexander on 02.11.2021.
//

import Foundation

protocol MainCollectionViewViewModelProtocol {
    
    func numberOfItems() -> Int
    func getAction(withIndexPath indexPath: IndexPath) -> Actions
    func cellViewModel(withIndexPath indexPath: IndexPath) -> MainCollectionViewCellViewModelProtocol?
}
