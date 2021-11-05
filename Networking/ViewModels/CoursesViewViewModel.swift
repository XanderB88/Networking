//
//  CoursesViewViewModel.swift
//  Networking
//
//  Created by Alexander on 29.10.2021.
//

import Foundation

class CoursesViewViewModel: CoursesViewViewModelProtocol {
    
    var swiftBookCourses = [Course]()
    
    func getCourses(withURL apiURL: String) {
        NetworkManager.shared.fetchCourses(withURL: apiURL) { courses in
            self.swiftBookCourses = courses
        }
    }
    
    
    func getCoursesAlamofire(withURL apiURL: String) {
        AlamofireNetworkingManager.shared.fetchCourses(withURL: apiURL) { courses in
            self.swiftBookCourses = courses
            print(self.swiftBookCourses)
        }
    }
    
    func getCourse(withIndexPath indexPath: IndexPath) -> Course {
        return swiftBookCourses[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return swiftBookCourses.count
    }
    
    func cellViewModel(withIndexPath indexPath: IndexPath) -> CourseTableViewCellViewModelProtocol? {
        let course = swiftBookCourses[indexPath.row]
        return CourseTableViewCellViewModel(course: course)
    }
    
}
