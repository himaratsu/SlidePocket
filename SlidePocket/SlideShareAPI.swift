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
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = Util().sha1(appendStr)
        
        return (String(timestamp), hash)
    }
    
    func getSlidesWitgTag(tag:String,
                      success:((AFHTTPRequestOperation!, AnyObject!) -> Void)!,
                      failure:((AFHTTPRequestOperation!, NSError!) -> Void)!)
        -> Void
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
        
        manager.GET(url, parameters: parameters, success: success, failure: failure)
    }
    
}