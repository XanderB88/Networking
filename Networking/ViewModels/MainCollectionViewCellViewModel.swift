//
//  MainCollectionViewCellViewModel.swift
//  Networking
//
//  Created by Alexander on 02.11.2021.
//

import Foundation

class MainCollectionViewCellViewModel: MainCollectionViewCellViewModelProtocol {
    
    private var action: Actions
    
    init(action: Actions) {
        self.action = action
    }
    
    var title: String {
        return action.rawValue
    }
}
