//
//  WKPlayerViewController.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 16/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit
import WebKit


class WKPlayerViewController: UIViewController {

    // MARK: - Interface
    @IBOutlet weak var webContainer: UIView!
    
    
    // MARK: - Properties
    lazy var webView : WKWebView = self.setWebView()
    let urlToLoad = "https://www.youtube.com/embed/TP9luRtEqjc"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIContainer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - PIPByWebKit -> WKPlayerViewController
typealias UIByWebKit = WKPlayerViewController
extension UIByWebKit {
    
    /// To set the WebKit webView
    fileprivate func setWebView() -> WKWebView {
        let v = WKWebView()
        v.navigationDelegate = self
        
        return v
    }
    
    /// Interface Rendered
    func setUIContainer() {
        /// add webView to container
        self.webContainer.addSubview(webView)
        
        /// setup auto layout
        let views = ["webView": webView]
        webView.translatesAutoresizingMaskIntoConstraints = false
        /// add constraints manually
        self.webContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|", options: .alignAllCenterX, metrics: nil, views: views))
        self.webContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|", options: .alignAllCenterY, metrics: nil, views: views))
        
        /// set html code to embed Html5 youtube video
        let htmlUrl = "<html><head><body style=\"(margin:0;padding:0;)\"><div class=\"h_iframe\"><iframe webkit-playsinline height=\"540\" width=\"950\" src=\"\(urlToLoad)?feature=player_detailpage&playsinline=1\" allowfullscreen></iframe></div></body></html>"
        
        /// load Html
        webView.loadHTMLString(htmlUrl, baseURL: nil)
    }
}


//MARK: - UIByWebKitNavDelegate -> WKPlayerViewController
typealias UIByWebKitNavDelegate = WKPlayerViewController
extension UIByWebKitNavDelegate: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("Navigation Action: \(navigationAction.request.url!.absoluteString)")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("Navigation Response: \(navigationResponse.response.mimeType!)")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("fail navigation: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("fail provisional navigation: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("did commit navigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish navigation")
    }
    
}
