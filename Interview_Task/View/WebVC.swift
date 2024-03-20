//
//  WebVC.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/30/23.
//

import Foundation
import UIKit
import WebKit




class WebVC: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    
        let url = URL(string: "https://github.com/mojombo")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

  
    }
    
}
