//
//  ViewController.swift
//  PlayRemoteVideo
//
//  Created by pratul patwari on 3/19/19.
//  Copyright © 2019 pratul patwari. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    let url = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    let mirus = "http://pratuls-macbook-air.local:8081/api/videos/watch/big_buck_bunny.mp4"
    let accessToken = "4038537e-76c8-46a8-948d-485151ec6a9a"
    
    var progress: Float = 0.0
    var task: URLSessionTask!
    
    var configuration = URLSessionConfiguration()
    
    let button: UIButton = {
        let b = UIButton()
        b.setTitle("Play Video", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .gray
        b.addTarget(self, action: #selector(downloadVideo), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.frame.width / 4).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    lazy var session : URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    var destinationURL: URL?
    
    @objc func downloadVideo(){
        if let destinationURL = destinationURL {
            playVideo(url: destinationURL)
        } else {
            let videoPath = "http://pratuls-macbook-air.local:8081/api/media/videos/watch/big_buck_bunny.mp4"
            let url = NSURL(string:videoPath)!
            let req = NSMutableURLRequest(url:url as URL)
            req.addValue("Bearer eeaa3aa8-cee0-416a-9a06-d815bd4fd40f", forHTTPHeaderField: "Authorization")
            req.addValue("application/json",forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = self.session.downloadTask(with: req as URLRequest)
            self.task = task
            task.resume()
        }
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let fileManager = FileManager()
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let docDirectoryURL = NSURL(fileURLWithPath: "\(directoryURL)")
        let destinationFilename = downloadTask.originalRequest?.url?.lastPathComponent
        destinationURL =  docDirectoryURL.appendingPathComponent("\(destinationFilename!)")
        if let path = destinationURL?.path {
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(at: destinationURL!)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
            }
        }
        do
        {
            try fileManager.copyItem(at: location, to: destinationURL!)
        }
        catch {
            print("Error while copy file")
        }
        if let destinationURL = destinationURL {
            playVideo(url: destinationURL)
        }
    }
    
    func playVideo(url: URL){
        let playerItem = AVPlayerItem(asset: AVAsset(url: url))
        let player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.navigationController?.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite < 0 {
            print("Session invalidated")
        } else {
            print("downloaded \(100*totalBytesWritten/totalBytesExpectedToWrite)")
        }
    }
}

