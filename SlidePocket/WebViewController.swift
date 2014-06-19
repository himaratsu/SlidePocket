//
//  WebViewController.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/19.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView
    var slide:Slide?
    
    override func viewDidLoad() {
        self.loadWebPage()
    }
    
    func loadWebPage() {
        if let slideObj = slide {
            self.title = slideObj.title
            var url:String = slideObj.url
            
            webView.loadRequest(NSURLRequest(URL: NSURL(string: url)))
        }
        else {
            println("No Slide Data")
        }
    }
    
    
}