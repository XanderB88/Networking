//
//  CourseTableViewCellProtocol.swift
//  Networking
//
//  Created by Alexander on 30.10.2021.
//


import UIKit

protocol CourseTableViewCellViewModelProtocol: AnyObject {
    
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numberOfTests: String { get }
    
    func getImage(completion: @escaping (UIImage) -> ())
    
}
