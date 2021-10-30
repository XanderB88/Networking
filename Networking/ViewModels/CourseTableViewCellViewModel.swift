//
//  File.swift
//  Networking
//
//  Created by Alexander on 30.10.2021.
//

import Foundation

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
    
    func getImage(completion: @escaping (Data) -> ()) {
        NetworkManager.shared.downloadImage(withURL: course.imageUrl) { data in
            let imageData = data
            completion(imageData)
        }
    }
    
    init(course: Course) {
        self.course = course
    }
    
}
