//
//  Courses.swift
//  Networking
//
//  Created by Alexander on 28.10.2021.
//

import Foundation

struct Course: Decodable {
    var id: Int
    var name: String
    var link: String
    var imageUrl: String
    var numberOfLessons: Int
    var numberOfTests: Int
}
