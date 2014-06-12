//
//  Slide.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import Foundation

class Slide {
    var title: String
    var url: String
    var viewCount: Int
    var favCount: Int
    var dlCount: Int
    
    init(title:String, url:String, viewCount:Int, favCount:Int, dlCount:Int) {
        self.title = title
        self.url = url
        self.viewCount = viewCount
        self.favCount = favCount
        self.dlCount = dlCount
    }
}