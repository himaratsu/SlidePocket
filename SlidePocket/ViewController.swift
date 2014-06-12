//
//  ViewController.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let kApiKey:String = "u25khrDY"
    let kApiSecret:String = "kJFifre0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
    }


    func reload() -> Void {
        var timestamp = HashString().unixtime()
        println("unix timestamp is \(timestamp)")
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = self.hashStr(appendStr)
        println("\(appendStr) -> \(hash)")
        
        self.getFlickrPhotos(String(timestamp), hash:hash)
        
    }
    
    
    // www.slideshare.net/api/2/get_slideshows_by_tag?tag=slideshare&limit=10&api_key=u25khrDY&hash=a13a321ae14859be107cb2363f4f4bb3c7904fb6&ts=1402570711
    func getFlickrPhotos(ts:String, hash:String) -> Void {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer();
        
        let url :String = "https://www.slideshare.net/api/2/get_slideshows_by_tag"
        let parameters :Dictionary = [
            "tag"         : "slideshare",
            "api_key"     : "u25khrDY",
            "ts"          : ts,
            "hash"        : hash,
            "limit"       : "10"
        ]

        println(parameters)
        
        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
    }
    
    func requestSuccess (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void {
        SVProgressHUD.dismiss()
        
        // xmldata
        if (responseObject) {
            var xml:NSData = responseObject as NSData
            var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
            
            var nodes: Array = doc.nodesForXPath("/Tag/Slideshow/Title", error:nil)
            for node: DDXMLNode! in nodes {
                println("slide title is '\(node.stringValue())'")
            }
        }
    }
    
    func requestFailure (operation :AFHTTPRequestOperation!, error :NSError!) -> Void {
        SVProgressHUD.dismiss()
        println("requestFailure \(error)")
    }
    
    func hashStr(str:String) -> String {
        return HashString().sha1(str)
    }
    
    @IBAction func reloadBtnTouched(sender : AnyObject) {
        reload()
    }
}

