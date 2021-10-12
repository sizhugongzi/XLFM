//
//  LBFMWebViewController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import WebKit

class LBFMWebViewController: UIViewController {

    private var url: String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }
    
}

