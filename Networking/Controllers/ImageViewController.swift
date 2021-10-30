//
//  ImageViewController.swift
//  Networking
//
//  Created by Alexander on 26.10.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = "https://applelives.com/wp-content/uploads/2016/04/apple-wallpaper-30.jpg"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
       
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.shared.downloadImage(withURL: url) { data in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}
