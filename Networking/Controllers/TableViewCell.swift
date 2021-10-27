//
//  TableViewCell.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var lesonsNumberLabel: UILabel!
    @IBOutlet weak var testsNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
