//
//  DisplayPDFVC.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import UIKit
import WebKit

class DisplayPDFVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var selectedcourseInfo: (name: String, url: String)?
    var wkWebView: WKWebView!
    
    override func loadView() {
        super.loadView()
        wkWebView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        wkWebView.allowsBackForwardNavigationGestures = true
        self.view = wkWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedcourseInfo!.name
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = URL(string: selectedcourseInfo!.url){
            wkWebView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopLoading()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startLoading()
    }
}
