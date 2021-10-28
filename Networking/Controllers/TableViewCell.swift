//
//  TableViewCell.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var lessonsNumberLabel: UILabel!
    @IBOutlet weak var testsNumberLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
