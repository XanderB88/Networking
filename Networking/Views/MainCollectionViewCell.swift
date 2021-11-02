//
//  MainCollectionViewCell.swift
//  Networking
//
//  Created by Alexander on 31.10.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actionLabel: UILabel!
    
    weak var viewModel: MainCollectionViewCellViewModel? {
        willSet(viewModel) {
            self.actionLabel.text = viewModel?.title
        }
    }
    
    
}
