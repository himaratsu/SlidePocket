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
    
//    var completion = ({(result: AnyObject!, error: NSError?) -> Void in println("Hello")})
//    var myCompletion :AnyObject? = nil
    
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
        
        manager.GET(url, parameters: parameters, success: self.requestSuccess(completion), failure: self.requestFailure)
    }
    
    func requestSuccess(completion:(NSDictionary?, NSError?) -> Void!) -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        return {
            (operation, response) in
            
            var result = self.parse(response)
            completion(result, nil)

            return;
        }
    }

    func parse(responseObject: AnyObject!) -> NSDictionary {
        var titles: Array<String> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var nodes: Array = doc.nodesForXPath("/Tag/Slideshow/Title", error:nil)
        for node: DDXMLNode! in nodes {
            titles += node.stringValue()
        }
        
        let result :NSDictionary = ["slide_titles" : titles]
        
        return result
    }

    func requestFailure (operation :AFHTTPRequestOperation!, error :NSError!) -> Void {
        SVProgressHUD.dismiss()
        println("requestFailure \(error)")
    }



}