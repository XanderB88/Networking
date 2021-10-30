//
//  File.swift
//  Networking
//
//  Created by Alexander on 30.10.2021.
//

import UIKit

class CourseTableViewCellViewModel: CourseTableViewCellViewModelProtocol {
    
    private var course: Course
    
    
    var courseName: String {
        return course.name
    }
    
    var numberOfLessons: String {
        return String(course.numberOfLessons)
    }
    
    var numberOfTests: String {
        return String(course.numberOfTests)
    }
    
    func getImage(completion: @escaping (UIImage) -> ()){
        NetworkManager.shared.downloadImage(withURL: course.imageUrl) { data in
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
    }
    
    init(course: Course) {
        self.course = course
    }
    
}
