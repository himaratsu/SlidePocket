//
//  SlideShareAPI.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/13.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import Foundation

class SlideShareAPI {
    let kApiKey:String = "u25khrDY"
    let kApiSecret:String = "kJFifre0"
    
    func generateUnixtimeAndHash() -> (ts:String, hash:String) {
        var timestamp = Util().unixtime()
        println("unix timestamp is \(timestamp)")
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = self.hashStr(appendStr)
        println("\(appendStr) -> \(hash)")
        
        return (String(timestamp), hash)
    }
    
    func getSlidesWitgTag(tag:String) -> Void {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer();
        
        var subParams = self.generateUnixtimeAndHash()
        
        let url :String = "https://www.slideshare.net/api/2/get_slideshows_by_tag"
        let parameters :Dictionary = [
            "tag"         : tag,
            "api_key"     : kApiKey,
            "ts"          : subParams.0,
            "hash"        : subParams.1,
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
    
    
    // -------------
    
    func hashStr(str:String) -> String {
        return Util().sha1(str)
    }
    
}