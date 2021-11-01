//
//  MainCollectionViewController.swift
//  Networking
//
//  Created by Alexander on 31.10.2021.
//

import UIKit

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case courses = "Courses"
    case downloadFiles = "Download Files"
}

private let reuseIdentifier = "ActionCell"
private let url = "https://jsonplaceholder.typicode.com/posts"

class MainCollectionViewController: UICollectionViewController {
    
    let actions = Actions.allCases
    
    private var alert: UIAlertController!
    private var dataProvider = DataProvider()
    
    private func showAlert() {
        alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: alert.view!,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 170)
        alert.view.addConstraint(height)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
            self.dataProvider.stopDownload()
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
           
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2, y: self.alert.view.frame.height / 2 - size.height / 2)
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
            
            let progressView = UIProgressView(frame: CGRect(x: 0, y: self.alert.view.frame.height - 44, width: self.alert.view.frame.width, height: 2))
            progressView.tintColor = .blue
            
            self.dataProvider.onProgress = { progress in
                
                progressView.progress = Float(progress)
                self.alert.message = String(Int(progress * 100)) + "%"
                
            }
            
            self.alert.view.addSubview(activityIndicator)
            self.alert.view.addSubview(progressView)
        }
        
    }
     
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        
        cell.actionLabel.text = actions[indexPath.row].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
            case .downloadImage:
                performSegue(withIdentifier: "showImage", sender: self)
            case .get:
                NetworkManager.shared.getRequest(withUrl: url)
            case .post:
                NetworkManager.shared.postRequest(withURL: url)
            case .courses:
                performSegue(withIdentifier: "showCourses", sender: self)
            case .downloadFiles:
                showAlert()
                dataProvider.startDownload()
        }
    }
}
