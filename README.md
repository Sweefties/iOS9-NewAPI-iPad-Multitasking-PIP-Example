![](https://img.shields.io/badge/build-pass-brightgreen.svg?style=flat-square)
![](https://img.shields.io/badge/platform-iOS9+-ff69b4.svg?style=flat-square)
![](https://img.shields.io/badge/Require-XCode7-lightgrey.svg?style=flat-square)


# iOS 9 - New API - iPad Multitasking - PiP Example
iOS 9~ Experiments - New API Components - Multitasking on iPad with Picture-in-Picture (PiP).

## Example

![](https://raw.githubusercontent.com/Sweefties/iOS9-NewAPI-iPad-Multitasking-PIP-Example/master/source/iPadOS9-Simulators-AVPlayerVCPiP-1.jpg)
![](https://raw.githubusercontent.com/Sweefties/iOS9-NewAPI-iPad-Multitasking-PIP-Example/master/source/iPadOS9-Simulators-AVPlayerVCPiP-2.jpg)
![](https://raw.githubusercontent.com/Sweefties/iOS9-NewAPI-iPad-Multitasking-PIP-Example/master/source/iPadOS9-Simulators-AVPlayerVCPiP-3.jpg)
![](https://raw.githubusercontent.com/Sweefties/iOS9-NewAPI-iPad-Multitasking-PIP-Example/master/source/iPadOS9-Simulators-AVPlayerVCPiP-4.jpg)
![](https://raw.githubusercontent.com/Sweefties/iOS9-NewAPI-iPad-Multitasking-PIP-Example/master/source/iPadOS9-Simulators-AVPlayerVCPiP-5.jpg)


## Requirements

- >= XCode 7.0 / 7.1 beta~. (writed with xcode 7.1 beta)
- >= Swift 2.
- >= iOS 9.0.
- >= iPad Mini 3 / 4, iPad Air / Air 2, iPad Pro

Tested on iOS 9.1 Simulators. 50%


## Important

Get the `master` branch for XCode 8 / Swift 3 updated project.


## Sources
WWDC 2015 Sessions from : [WWDC 2015 Videos](https://developer.apple.com/videos/wwdc/2015/)
Jamie XX - Loud Places (feat. Romy) from : [youtube.com](https://youtu.be/TP9luRtEqjc)


## App Transport Security Settings

To support HTTP hosted : add the Boolean type Value to `YES` for `NSAllowsArbitraryLoads` in app's `info.plist` file.


## Usage

- To run the example project, download or clone the repo.
- MULTITASKING RECOMMANDATIONS : Perform and prepare your app to avoid memory leaks and others with Instruments!
- IN USE OF `AVPictureInPictureController` , use : `AVPictureInPictureController.isPictureInPictureSupported()` to get devices capability


### Example Code!


- Set your `AVPlayer`, `AVPlayerViewController` or `AVPlayerLayer` in one controller to play video!
- Add `AVKit` + `AVFoundation` Frameworks

```swift
import AVKit
import AVFoundation
```


- Set `AVAudioSession` in `didFinishLaunchingWithOptions` UIApplication Delegate
```swift
/// REQUIRED FOR PIP!!!
/// After active Audio/Airplay Background Mode in General Settings.
/// Setup Audio Session for Picture in Picture
let audioSession = AVAudioSession.sharedInstance()

do {
    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
}
catch {
    print("handle errors setting Audio session Category")
}
```

- Delegate your controller with `AVPlayerViewControllerDelegate` Extension
```swift
extension ViewController : AVPlayerViewControllerDelegate {

    /// playerViewController will start PIP
    func playerViewControllerWillStartPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP will start")
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
        print("PIP Error : \(error.localizedDescription)")
    }

    /// playerViewController automatically dismiss at PIP Start.
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(playerViewController: AVPlayerViewController) -> Bool {
        return false
    }

    /// playerViewController restore Interface For PIP
    func playerViewController(playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: (Bool) -> Void) {

    // if topView and navigation controller :
        if let topViewController = navigationController?.topViewController {
            topViewController.presentViewController(playerViewController, animated: true) {
                print("ready detailvc restore presentViewController")
                completionHandler(true)
            }
        }
        else {
            completionHandler(false)
        }
    }
}
```


Build and Run!
Switch to Home or another App in your simulator or devices and test!
