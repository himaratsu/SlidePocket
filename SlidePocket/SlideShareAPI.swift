//
//  SlideShareAPI.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/13.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import Foundation

class SlideShareAPI {
    // TODO: AppDelegateから渡せるようにする
    // API Key
    let kApiKey:String = "u25khrDY"
    let kApiSecret:String = "kJFifre0"
    
    // unixタイムとハッシュを準備する
    func generateUnixtimeAndHash() -> (ts:String, hash:String) {
        var timestamp = Util().unixtime()
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = Util().sha1(appendStr)
        
        return (String(timestamp), hash)
    }
    
    // APIにアクセスする
    func getApiAccessWithPath(path:String,
                            params:NSMutableDictionary,
                            completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!,
                            parser:(AnyObject!) -> NSDictionary) -> Void
    {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer();

        let url :String = "https://www.slideshare.net/api/2/\(path)"
        var subParams = self.generateUnixtimeAndHash()
        
        params["api_key"] = kApiKey
        params["ts"] = subParams.0
        params["hash"] = subParams.1
        
        println(params)
        
        // TODO: アクセスするAPIに応じてparserの種類を変更する
        manager.GET(url,
            parameters: params,
            success: self.requestSuccess(completion, parser),
            failure: self.requestFailure(completion))
    }
    
    
    // tagをもとにスライド検索する
    func getSlidesWitgTag(tag:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {

        let params :NSMutableDictionary = [
            "tag"         : tag,
            "detailed"    : "1",
            "limit"       : "10"
        ]
        
        // TODO: 処理によって渡すparserは変更する
        self.getApiAccessWithPath("get_slideshows_by_tag", params: params, completion: completion, parser:self.parseResponse)
    }
    
    // 通信成功時の処理
    func requestSuccess(completion:(NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void!,
                            parser:(AnyObject!) -> NSDictionary)
                        -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        return {
            (operation, responseObject) in
            
            // TODO: 通信成功したけどエラー（tokenエラーとか）に対応する
            var result = parser(responseObject)
            completion(operation.response, result, nil)

            return
        }
    }
    
    // 通信失敗時の処理
    func requestFailure(completion:(NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void!) -> ((AFHTTPRequestOperation!, NSError!) -> Void) {
        return {
            (operation, error) in
            completion(operation.response, nil, error)
            return
        }
    }
    
    // /api/2/get_slideshows_by_tag のレスポンスをparseしてスライドタイトルを取り出す
    func parseResponse(responseObject: AnyObject!) -> NSDictionary {
        var slides: Array<Slide> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var nodes: Array = doc.nodesForXPath("/Tag/Slideshow", error:nil)
        for node: DDXMLNode! in nodes {
            var slide: Slide = Slide(xmlNode: node)
            slides += slide
        }
        
        let result :NSDictionary = ["slides" : slides]
        
        return result
    }

}
