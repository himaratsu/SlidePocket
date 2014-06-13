//
//  ViewController.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reload()
    }

    func reload() -> Void {
        SVProgressHUD.show()
        var api: SlideShareAPI = SlideShareAPI()
        api.getSlidesWitgTag("swift", self.completion)
    }
    
    func completion(result: AnyObject?, error: NSError?) -> Void {
//        println("complete")
    }
    
//    func requestSuccess (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void {
//        SVProgressHUD.dismiss()
//        
//        // xmldata
//        if (responseObject) {
//            var xml:NSData = responseObject as NSData
//            var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
//            
//            var nodes: Array = doc.nodesForXPath("/Tag/Slideshow/Title", error:nil)
//            for node: DDXMLNode! in nodes {
//                println("slide title is '\(node.stringValue())'")
//            }
//        }
//    }
//    
//    func requestFailure (operation :AFHTTPRequestOperation!, error :NSError!) -> Void {
//        SVProgressHUD.dismiss()
//        println("requestFailure \(error)")
//    }


    @IBAction func reloadBtnTouched(sender : AnyObject) {
        reload()
    }
}

