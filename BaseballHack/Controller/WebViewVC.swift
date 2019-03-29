//
//  TeamInfoVC.swift
//  BaseballHack
//
//  Created by Zak Aroui on 3/9/19.
//  Copyright © 2019 GameChanger. All rights reserved.
//

import UIKit
import WebKit

enum WebViewSource {
    case social
    case asset
}

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var teamSocial: TeamSocial?
    var teamAsset: TeamAssest?
    var sourceVc: WebViewSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        
        switch sourceVc {
        case .social?:
            urlString = teamSocial?.url ?? ""
        case .asset?:
            urlString = teamAsset?.url ?? ""
        case .none:
            urlString = ""
        }
        
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
}
