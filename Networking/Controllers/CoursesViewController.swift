//
//  CoursesViewController.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var swiftBookCourses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoursesNetworkManager.shared.fetchCourses { courses in
            self.swiftBookCourses = courses
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        cell.lessonsNumberLabel.text = "Lessons: \(course.number_of_lessons)"
        cell.testsNumberLabel.text = "Tests: \(course.number_of_tests)"
        
        DispatchQueue.main.async {
            
            cell.courseImage.image = self.fetchCourseImage(withURL: course.imageUrl)
    
        }
        
        return cell
    }
    
    private func fetchCourseImage(withURL url: String) -> UIImage {
        guard let url = URL(string: url), let imageData = try? Data(contentsOf: url) else { return UIImage()}
        guard let image = UIImage(data: imageData) else { return UIImage()}
        return image
    }
    
}
