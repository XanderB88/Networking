//
//  CoursesViewViewModelProtocol.swift
//  Networking
//
//  Created by Alexander on 29.10.2021.
//

import Foundation

protocol CoursesViewViewModelProtocol {
    
    var swiftBookCourses: [Course] { get set }
    
    func getCourses(withURL apiURL: String) 
    func getCourse(withIndexPath indexPath: IndexPath) -> Course
    func numberOfRows() -> Int
    
}
