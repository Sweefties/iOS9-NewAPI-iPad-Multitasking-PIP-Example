//
//  MovieDetailViewController.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 15/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class MovieDetailViewController: UIViewController {

    
    // MARK: - Interface
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieButton: UIButton!
    
    
    // MARK: - Properties
    let playerVC = AVPlayerViewController()
    var pictureInPicureIsActive = false
    var currentMovieUrl = String()
    
    dynamic var movieObject = MoviesLibrary()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playerVC.delegate = self
        setUIComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - UIForMovieDetails -> MovieDetailViewController Extension
typealias UIForMovieDetails = MovieDetailViewController
extension UIForMovieDetails {
    
    /// rendered view
    func setUIComponents() {
        /// object
        guard let movie = movieObject as MoviesLibrary? else { print("no value") }
        
        /// string url for player
        currentMovieUrl = movie.movieUrl
        
        /// text labels interface
        self.movieTitleLabel.text = movie.title
        self.movieDescription.text = movie.descriptionText
        
        /// image interface (only for this demo project)
        /// CAUTION : You must preferred one helper class with performed methods (by example : cache, NSURLSession, NSURLResponse.. and MANAGE CACHE MEMORY!!!)
        var image = UIImage()
        if let imgUrl = movie.thumbnailUrl as String? {
            
            DispatchQueue.global(qos: .userInteractive).async(execute: {
                if let data = try? Data(contentsOf: URL(string: imgUrl)!) {
                    image = UIImage(data: data)!
                    
                    DispatchQueue.main.async {
                        self.movieThumbnail.image = image
                    }
                }
            })
        }
        
        /// button interface
        self.movieButton.layer.cornerRadius = movieButton.frame.size.width / 2
        self.movieButton.layer.masksToBounds = true
        self.movieButton.layoutIfNeeded()
    }
}


//MARK: - AVPlayerVCActions -> MovieDetailViewController Extension
typealias AVPlayerVCActions = MovieDetailViewController
extension AVPlayerVCActions {
    
    /// play movie in modal
    @IBAction func playMovie(_ sender: AnyObject) {
        if !currentMovieUrl.isEmpty {
            playerVC.player = AVPlayer(url: URL(string: currentMovieUrl)!)
            present(playerVC, animated: true) { () -> Void in
                self.playerVC.player?.play()
            }
        }
    }
}


//MARK: - PIPAVPlayerVCDelegate -> MovieDetailViewController Extension
private typealias PIPAVPlayerVCDelegate = MovieDetailViewController
extension PIPAVPlayerVCDelegate : AVPlayerViewControllerDelegate {
    
    /// playerViewController will start PIP
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PIP will start")
        pictureInPicureIsActive = true
    }
    
    /// playerViewController did start PIP
    func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PIP did start")
    }
    
    /// playerViewController will stop PIP
    func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PIP will stop")
    }
    
    /// playerViewController did stop PIP
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PIP did stop")
    }
    
    /// playerViewController failed to start PIP
    func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        pictureInPicureIsActive = false
        print("PIP Error : \(error.localizedDescription)")
    }
    
    /// playerViewController automatically dismiss at PIP Start.
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        return false
    }
    
    /// playerViewController restore Interface For PIP
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
        present(playerViewController, animated: true) {
            print("PIP restore process loading..")
            completionHandler(true)
        }
        //if topView and navigation controller :
        //if let topViewController = navigationController?.topViewController {
        //    topViewController.presentViewController(playerViewController, animated: true) {
        //        print("ready detailvc restore presentViewController")
        //        completionHandler(true)
        //    }
        //}
        //else {
        //    completionHandler(false)
        //}
    }
}
