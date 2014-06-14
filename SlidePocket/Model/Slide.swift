//
//  Slide.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
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
    var tags :Array<AnyObject>?
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
    }
    
    
    func simpleDescription() -> String {
        return "id:\(slideId) title:\(title) description:\(description) userName:\(userName) url:\(url) thumbUrl:\(thumbnailUrl)";
    }
    
}



