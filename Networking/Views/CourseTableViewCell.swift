//
//  TableViewCell.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var lessonsNumberLabel: UILabel!
    @IBOutlet weak var testsNumberLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    
    
    weak var viewModel: CourseTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
           
            courseNameLabel.text = viewModel.courseName
            lessonsNumberLabel.text = viewModel.numberOfLessons
            testsNumberLabel.text = viewModel.numberOfTests
            viewModel.getImage { image in
                DispatchQueue.main.async {
                    self.courseImage.image = image
                }
            }
        }
    }
}
