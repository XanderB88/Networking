//
//  DataProvider.swift
//  Networking
//
//  Created by Alexander on 01.11.2021.
//

import Foundation
import UIKit

class DataProvider: NSObject {
    
    private var downloadTask: URLSessionDownloadTask!
    
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    
    private lazy var backGroundSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "AlexanderBykov.Networking")
        config.isDiscretionary =  true   // Start of task in optimal time
        config.timeoutIntervalForResource = 300 // A waiting time of cellular in seconds
        config.waitsForConnectivity = true // Waiting for cellular connection
        config.sessionSendsLaunchEvents =  true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil) //
    }()
    
    func startDownload() {
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            downloadTask = backGroundSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
    
    
}

extension DataProvider: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
            else { return }
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Downloading is finished: \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("Download progress: \(progress)")
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
    
}
