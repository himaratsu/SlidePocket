//
//  Slide.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/12.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class Slide {
    // basic -----------------------
    var slideId: String
    var title: String
    var description: String
    var status :Int? // ?
    var userName :String
    var url: String
    var thumbnailUrl: String
    var thumbnailSmallUrl: String?
    var embed: String?
    var created: String?
    var updated: String?
    var language: String?
    var format: String?
    var download: Int?   // can download? FIXME: BOOL
    var downloadUrl: String?
    var slideshowType: Int?  // ?
    var inContest :Int?  // ?
    
    // detail -----------------------
    var thumbnailSize: String?   // FIXME: [170, 130]
    var userId: String?
    var pptLocation: String?
    var strippedTitle: String?
    var tags :Array<Tag>?
    var audio :Int?  // ?
    var numDownloads :Int?
    var numViews: Int?
    var numComments: Int?
    var numFavorites: Int?
    var numSlides: Int?
    var relatedSlideshows: Array<Slide>? // FIXME: ???
    var privacyLevel: Int?   // FIXME: Bool?
    var flagVisible: Int?    // FIXME:
    var showOnSS: Int?       // ???
    var secretUrl:  String?
    var allowEmbed: Int?     // FIXME
    var shareWithContacts: Int?  // FIXME
    
    
    init(xmlNode: DDXMLNode) {
        self.slideId = Util.nodeStringWithNode(xmlNode, key: "ID")
        self.title = Util.nodeStringWithNode(xmlNode, key: "Title")
        self.description = Util.nodeStringWithNode(xmlNode, key: "Description")
        self.userName = Util.nodeStringWithNode(xmlNode, key: "Username")
        self.url = Util.nodeStringWithNode(xmlNode, key: "URL")
        self.thumbnailUrl = "http:" + Util.nodeStringWithNode(xmlNode, key: "ThumbnailURL")
        
//        self.thumbnailSize
        self.userId = Util.nodeStringWithNode(xmlNode, key: "UserID")
        self.pptLocation = Util.nodeStringWithNode(xmlNode, key: "PPTLocation") // swift-1406-140614231948-phpapp01
        self.strippedTitle = Util.nodeStringWithNode(xmlNode, key: "StrippedTitle") // swift-35939978
        
        var tmpTags: Array<Tag> = []
        var tags: Array = xmlNode.nodesForXPath("Tags/Tag", error: nil)
        
        for tag : AnyObject in tags {
            var title:String = tag.stringValue
            var count:Int = (tag as DDXMLElement).attributeForName("Count").stringValue().toInt()!
            
            var tag:Tag = Tag(title:title, count:count)
            tmpTags += tag
        }
        self.tags = tmpTags
    }
    
    func simpleDescription() -> String {
        return "id:\(slideId) title:\(title) description:\(description) userName:\(userName) url:\(url) thumbUrl:\(thumbnailUrl)";
    }
    
}



