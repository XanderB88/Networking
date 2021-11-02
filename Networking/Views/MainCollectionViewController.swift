//
//  MainCollectionViewController.swift
//  Networking
//
//  Created by Alexander on 31.10.2021.
//

import UIKit
import UserNotifications

private let reuseIdentifier = "ActionCell"
private let url = "https://jsonplaceholder.typicode.com/posts"

class MainCollectionViewController: UICollectionViewController {
   
    private var alert: UIAlertController!
    private var dataProvider = DataProvider()
    private var filePath: String?
    private var viewModel: MainCollectionViewViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainCollectionViewViewModel()
        
        registerForNotifications()
        
        dataProvider.fileLocation = { location in
            
            self.filePath = location.absoluteString
            self.alert.dismiss(animated: false, completion: nil)
            self.postNotification()
        }
    }
    
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
        return viewModel?.numberOfItems() ?? .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        guard let viewModel = viewModel else { return cell }
        
        let cellViewModel = viewModel.cellViewModel(withIndexPath: indexPath)
        
        cell.viewModel = cellViewModel as? MainCollectionViewCellViewModel
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        let action = viewModel.getAction(withIndexPath: indexPath)
        
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

// MARK: - Notifications

extension MainCollectionViewController {
    
    private func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in
            
        }
    }
    
    private func postNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Download complete"
        content.body = "Your background transfer has completed. File path: \(filePath!)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
