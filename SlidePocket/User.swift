//
//  User.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/17.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class User {
    var name:String
    var count:Int
    var slides:Array<Slide>
    
    init(xmlNode: DDXMLNode) {
        self.name = Util.nodeStringWithNode(xmlNode, key: "Name")
        self.count = Util.nodeStringWithNode(xmlNode, key: "Count").toInt()!
        
        var nodes: Array = xmlNode.nodesForXPath("Slideshow", error:nil)

        var slides: Array<Slide> = []
        for node: DDXMLNode! in nodes {
            var slide: Slide = Slide(xmlNode: node)
            slides += slide
        }
        
        self.slides = slides
        
    }
    
    func simpleDescription() -> String {
        return "name:\(name) count:\(count) slides_count:\(slides.count)"
    }
}