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
    
    var completion = ({(result: AnyObject!, error: NSError?) -> Void in println("Hello")})
    var myCompletion :AnyObject? = nil
    
    func generateUnixtimeAndHash() -> (ts:String, hash:String) {
        var timestamp = Util().unixtime()
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = Util().sha1(appendStr)
        
        return (String(timestamp), hash)
    }
    
    func getSlidesWitgTag(tag:String, completion:((NSDictionary?, NSError?) -> Void)!) -> Void
    {
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
        
        
        // callback ----
        let successCallback = {
            (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            
            var titles: Array<String> = []
            
            // xmldata
            if (responseObject) {
                var xml:NSData = responseObject as NSData
                var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
                
                var nodes: Array = doc.nodesForXPath("/Tag/Slideshow/Title", error:nil)
                for node: DDXMLNode! in nodes {
                    titles += node.stringValue()
                }
            }
            
            let result :Dictionary = ["slide_titles":titles]
            completion(result, nil)
        }
        
        manager.GET(url, parameters: parameters, success: successCallback, failure: self.requestFailure)
    }

    
    func requestFailure (operation :AFHTTPRequestOperation!, error :NSError!) -> Void {
        SVProgressHUD.dismiss()
        println("requestFailure \(error)")
    }



}