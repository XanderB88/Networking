//
//  DetailViewController.swift
//  Networking
//
//  Created by Alexander on 29.10.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var urlLink = ""
    var selectedCourse: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCourse
        downloadWebPage(withURL: urlLink)
        
    }
    
    private func downloadWebPage(withURL courseURL: String) {
        guard let url = URL(string: courseURL) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
       
    }
}


