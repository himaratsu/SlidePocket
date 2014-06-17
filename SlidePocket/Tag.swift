//
//  Tag.swift
//  SlidePocket
//
//  Created by himara2 on 2014/06/14.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class Tag {
    var title: String
    var count: Int
    
    init(title:String, count:Int) {
        self.title = title;
        self.count = count;
    }
    
    init(xmlNode: DDXMLNode) {
        self.title = Util.nodeStringWithNode(xmlNode, key: "Name")
        self.count = Util.nodeStringWithNode(xmlNode, key: "Count").toInt()!
    }
    
    func simpleDescription() -> String {
        return "title:\(title) count:\(count)"
    }
}