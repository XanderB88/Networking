//
//  CoursesViewController.swift
//  Networking
//
//  Created by Alexander on 27.10.2021.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var apiURL = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
    private var courseName: String?
    private var courseURL: String?
    var viewModel: CoursesViewViewModelProtocol?
   
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CoursesViewViewModel()
        viewModel?.getCourses(withURL: apiURL)

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
        return viewModel?.numberOfRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CourseTableViewCell

        guard let viewModel = viewModel else { return cell }
        
        let cellViewModel = viewModel.cellViewModel(withIndexPath: indexPath)
        
        cell.viewModel = cellViewModel as? CourseTableViewCellViewModel
        
        return cell
    }
    
    private func fetchCourseImage(withCell cell: CourseTableViewCell, withURL url: String) {
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
        
        let course = viewModel?.getCourse(withIndexPath: indexPath)
        
        courseURL = course?.link
        courseName = course?.name
        
        performSegue(withIdentifier: "ShowPage", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
