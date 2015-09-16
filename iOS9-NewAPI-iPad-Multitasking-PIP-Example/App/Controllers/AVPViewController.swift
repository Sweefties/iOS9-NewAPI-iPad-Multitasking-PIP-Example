//
//  AVPViewController.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 16/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class AVPViewController: UIViewController {

    
    // MARK: - Properties
    let playerVC = AVPlayerViewController()
    var pictureInPicureIsActive = false
    let urlToStream = "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playerVC.delegate = self
        setUIRendered()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - UIPIPAVPInterface -> AVPViewController Extension
typealias UIPIPAVPInterface = AVPViewController
extension UIPIPAVPInterface {
    
    /// Player View Rendered and Play!
    func setUIRendered() {
        // layout player
        playerVC.view.frame = CGRectMake(0, 64, 768, 432)
        self.view.addSubview(playerVC.view)
        
        // prepare the player
        playerVC.player = AVPlayer(URL: NSURL(string: urlToStream)!)
        
        // present the player is playing
        playerVC.player?.play()
    }
    
}


//MARK: - PIPAVPViewControllerDelegate -> AVPViewController Extension
private typealias PIPAVPlayerVCDelegate = AVPViewController
extension PIPAVPlayerVCDelegate : AVPlayerViewControllerDelegate {
    
    /// playerViewController will start PIP
    func playerViewControllerWillStartPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP will start")
        pictureInPicureIsActive = true
    }
    
    /// playerViewController did start PIP
    func playerViewControllerDidStartPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP did start")
    }
    
    /// playerViewController will stop PIP
    func playerViewControllerWillStopPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP will stop")
    }
    
    /// playerViewController did stop PIP
    func playerViewControllerDidStopPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP did stop")
    }
    
    /// playerViewController failed to start PIP
    func playerViewController(playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: NSError) {
        pictureInPicureIsActive = false
        print("PIP Error : \(error.localizedDescription)")
    }
    
    /// playerViewController restore Interface For PIP
    func playerViewController(playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: (Bool) -> Void) {
        print("PIP restore process loading..")
        completionHandler(true)
    }
}