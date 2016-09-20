//
//  MoviesCollectionViewController.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 15/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class MoviesCollectionViewController: UICollectionViewController {

    
    // MARK: - Properties
    dynamic var dataArray = [MoviesLibrary]()

    fileprivate let reuseIdentifier = "Cell"
    fileprivate let segueIdentifier = "ShowDetailForMovie"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - MoviesAVPlayerVCPipDelegate -> MoviesCollectionViewController Extension
typealias MoviesAVPlayerVCPipDelegate = MoviesCollectionViewController
extension MoviesAVPlayerVCPipDelegate : AVPlayerViewControllerDelegate {
    
    /// playerViewController will start PIP
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PIP will start")
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


//MARK: - MoviesCollectionDataSource -> MoviesCollectionViewController Extension
typealias MoviesCollectionDataSource = MoviesCollectionViewController
extension MoviesCollectionDataSource {
    
    /// Number of Sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /// Number of Items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count 
    }
    
    /// Cell for Item
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        guard let movie = dataArray[(indexPath as NSIndexPath).item] as MoviesLibrary? else { print("no value") }
        // Configure the cell
        let viewModel = MovieViewModel()
        cell.configure(withDataSource: movie, delegate: viewModel)
        
        return cell
    }
}


//MARK: - MoviesCollectionDelegate -> MoviesCollectionViewController Extension
typealias MoviesCollectionDelegate = MoviesCollectionViewController
extension MoviesCollectionDelegate {
    
    /// Did Select Item
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}


//MARK: - MoviesNavigation -> MoviesCollectionViewController Extension
typealias MoviesNavigation = MoviesCollectionViewController
extension MoviesNavigation {
    
    /// Navigation Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueIdentifier) {
            if let row = (self.collectionView?.indexPathsForSelectedItems?.first as NSIndexPath?)?.row, let detailViewController = segue.destination as? MovieDetailViewController {
                detailViewController.movieObject = dataArray[row]
            }
        }
    }
}


//MARK: - DataSetted -> MoviesCollectionViewController Extension
private typealias DataSetted = MoviesCollectionViewController
extension DataSetted {
    
    /// set Datas
    func setNewDatas() {
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 102",
            descriptionText: "WWDC 2015 Platforms State of the Union",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/1026npwuy2crj2xyuq11/102/images/102_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/1026npwuy2crj2xyuq11/102/102_sd_platforms_state_of_the_union.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 105",
            descriptionText: "WatchKit for watchOS 2 introduces many new capabilities for creating responsive Watch...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/105ncyldc6ofunvsgtan/105/images/105_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/105ncyldc6ofunvsgtan/105/105_sd_introducing_watchkit_for_watchos_2.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 106",
            descriptionText: "Swift continues its rapid advancement with version 2. New optimizations make your app run even...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/106z3yjwpfymnauri96m/106/images/106_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/106z3yjwpfymnauri96m/106/106_sd_whats_new_in_swift.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 104",
            descriptionText: "Xcode is the development environment for creating great apps for Apple's platforms. Start the...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/104usewvb5m0qbwafx8p/104/images/104_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/104usewvb5m0qbwafx8p/104/104_sd_whats_new_in_xcode.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 802",
            descriptionText: "Apple Watch represents a new chapter in the way people relate to technology. It's the most...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/802mpzd3nzovlygpbg/802/images/802_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/802mpzd3nzovlygpbg/802/802_sd_designing_for_apple_watch.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 709",
            descriptionText: "Making your app more discoverable leads to more downloads and generates revenue. iOS 9 adds a...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/709jcaer6su/709/images/709_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/709jcaer6su/709/709_sd_introducing_search_apis.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 801",
            descriptionText: "Design for tomorrow's products today. See examples of how Apple and partners designed software...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/801auxyvb1pgtkufjk/801/images/801_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/801auxyvb1pgtkufjk/801/801_sd_designing_for_future_hardware.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 212",
            descriptionText: "Multitasking in iOS 9 allows two side-by-side apps and the Picture-in-Picture window to...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/212mm5ra3oau66/212/images/212_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/212mm5ra3oau66/212/212_sd_optimizing_your_app_for_multitasking_on_ipad_in_ios_9.mp4?dl=1"))
        dataArray.append(MoviesLibrary(
            title: "WWDC 2015 Session : 408",
            descriptionText: "At the heart of Swift's design are two incredibly powerful ideas: protocol-oriented programming...",
            thumbnailUrl: "http://devstreaming.apple.com/videos/wwdc/2015/408509vyudbqvts/408/images/408_734x413.jpg",
            movieUrl: "http://devstreaming.apple.com/videos/wwdc/2015/408509vyudbqvts/408/408_sd_protocoloriented_programming_in_swift.mp4?dl=1"))
    }
}
