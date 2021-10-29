//
//  CoursesViewController.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    private var swiftBookCourses = [Course]()
    private var courseName: String?
    private var courseURL: String?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoursesNetworkManager.shared.fetchCourses { courses in
            self.swiftBookCourses = courses
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        
        detailViewController.selectedCourse = courseName
       
        if let url = courseURL {
            detailViewController.urlLink = url
        }
    }
}

// MARK: - Table view data source

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBookCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let course = swiftBookCourses[indexPath.row]

        cell.courseNameLabel.text = course.name
        cell.lessonsNumberLabel.text = "Lessons: \(course.numberOfLessons)"
        cell.testsNumberLabel.text = "Tests: \(course.numberOfTests)"
        
        fetchCourseImage(withCell: cell, withURL: course.imageUrl)
        
        return cell
    }
    
    private func fetchCourseImage(withCell cell: TableViewCell, withURL url: String) {
        DispatchQueue.global().async {
          
            guard let url = URL(string: url), let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
            
        }
        
    }
}

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = swiftBookCourses[indexPath.row]
        
        courseURL = course.link
        courseName = course.name
        
        performSegue(withIdentifier: "ShowPage", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
