//
//  SlideShareAPI.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/13.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class SlideShareAPI {
    // TODO: receive from AppDelegate
    // API Key
    let kApiKey:String = "u25khrDY"
    let kApiSecret:String = "kJFifre0"
    
    // ready for unixtime and hash
    func generateUnixtimeAndHash() -> (ts:String, hash:String) {
        var timestamp = Util().unixtime()
        
        var appendStr = "\(kApiSecret)\(timestamp)"
        var hash:String = Util().sha1(appendStr)
        
        return (String(timestamp), hash)
    }
    
    // Common ----------------------------------------------------------------------------------------
    // access API (GET)
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
        
        manager.GET(url,
            parameters: params,
            success: self.requestSuccess(completion, parser),
            failure: self.requestFailure(completion))
    }
    
    // connection success
    func requestSuccess(completion:(NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void!,
        parser:(AnyObject!) -> NSDictionary)
        -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
            return {
                (operation, responseObject) in
                
                // TODO: process that network is success but response is error
                var result = parser(responseObject)
                completion(operation.response, result, nil)
                
                return
            }
    }
    
    // connection failed
    func requestFailure(completion:(NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void!) -> ((AFHTTPRequestOperation!, NSError!) -> Void) {
        return {
            (operation, error) in
            completion(operation.response, nil, error)
            return
        }
    }

    // Slideshare API =================================================================================
    
    // get_slideshow ---------------------------------------------------------------------------
    // get api access
    func getSlides(#slideshowId:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {
        
        let params :NSMutableDictionary = [
            "slideshow_id": slideshowId,
            "detailed"    : "1"
        ]
        
        self.getApiAccessWithPath("get_slideshow", params: params, completion: completion, parser:self.parseSlidesResponse)
    }
    
    func getSlides(#slideshowUrl:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {
        
        let params :NSMutableDictionary = [
            "slideshow_url": slideshowUrl,
            "detailed"     : "1"
        ]
        
        self.getApiAccessWithPath("get_slideshow", params: params, completion: completion, parser:self.parseSlidesResponse)
    }
    
    // parse result
    func parseSlidesResponse(responseObject: AnyObject!) -> NSDictionary {
        var slides: Array<Slide> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var node: Array = doc.nodesForXPath("/Slideshow", error: nil);
        var slide:Slide = Slide(xmlNode: (node[0] as DDXMLNode))
        
        // FIXME: bug? dictionary cannot init with multiple key-values.
        let result :NSDictionary = ["slide" : slide]
        
        return result
    }

    
    
    // get_slideshow_by_tag ---------------------------------------------------------------------------
    // get api access
    func getSlidesWithTag(tag:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {

        let params :NSMutableDictionary = [
            "tag"         : tag,
            "detailed"    : "1",
            "limit"       : "10"
        ]
        
        self.getApiAccessWithPath("get_slideshows_by_tag", params: params, completion: completion, parser:self.parseSlidesWithTagResponse)
    }
    
    // parse result
    func parseSlidesWithTagResponse(responseObject: AnyObject!) -> NSDictionary {
        var slides: Array<Slide> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var tagNodes: Array = doc.nodesForXPath("/Tag", error: nil);
        var tag: Tag = Tag(xmlNode: (tagNodes[0] as DDXMLNode))
        
        var nodes: Array = doc.nodesForXPath("/Tag/Slideshow", error:nil)
        for node: DDXMLNode! in nodes {
            var slide: Slide = Slide(xmlNode: node)
            slides += slide
        }
        
        // FIXME: bug? dictionary cannot init with multiple key-values.
        let result :NSDictionary = ["slides" : slides, "tag":tag]
        
        return result
    }
    
    
    // get_slideshow_by_user ---------------------------------------------------------------------------
    // get api access
    func getSlidesWithUser(username:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {
        
        let params :NSMutableDictionary = [
            "username_for": username,
            "detailed"    : "1",
            "limit"       : "10"
        ]
        
        self.getApiAccessWithPath("get_slideshows_by_user", params: params, completion: completion, parser:self.parseSlidesWithUserResponse)
    }
    
    // parse result
    func parseSlidesWithUserResponse(responseObject: AnyObject!) -> NSDictionary {
        var slides: Array<Slide> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var userNodes: Array = doc.nodesForXPath("/User", error: nil)
        var user: User = User(xmlNode: (userNodes[0] as DDXMLNode))
        
        let result :NSDictionary = ["user" : user]
        
        return result
    }
    

    
    // search slideshow by query ---------------------------------------------------------------------------
    // get api access
    func searchSlidesWithQuery(query:String, completion:((NSHTTPURLResponse?, NSDictionary?, NSError?) -> Void)!) -> Void
    {
        
        let params :NSMutableDictionary = [
            "q"                    : query,
            "items_per_page"       : "20"
        ]
        
        self.getApiAccessWithPath("search_slideshows", params: params, completion: completion, parser:self.parseSearchSlideResponse)
    }
    
    // parse result
    func parseSearchSlideResponse(responseObject: AnyObject!) -> NSDictionary {
        var slides: Array<Slide> = []
        
        var xml:NSData = responseObject as NSData
        var doc:DDXMLDocument = DDXMLDocument(data: xml, options:0, error:nil)
        
        var nodes: Array = doc.nodesForXPath("/Slideshows/Slideshow", error:nil)
        for node: DDXMLNode! in nodes {
            var slide: Slide = Slide(xmlNode: node)
            slides += slide
        }
        
        let result :NSDictionary = ["slides" : slides]
        
        return result
    }

    
}
