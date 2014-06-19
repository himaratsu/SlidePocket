//
//  SlideshowCell.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatasu on 2014/06/19.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import Foundation

class SlideshowCell : UITableViewCell {
    
    @IBOutlet var thumbImageView: UIImageView
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var usernameLabel: UILabel
    @IBOutlet var hatebuCountLabel: UILabel

    func getCountHatenaBookmark(slideUrl: String) -> Void {
        self.hatebuCountLabel.hidden = true
        
        var escapeStr:String = Util.escapeString(slideUrl)
        var requestUrl:String = "http://api.b.st-hatena.com/entry.count?url="+escapeStr
        
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer();
        
        manager.GET(requestUrl,
            parameters: nil,
            success: {
                (operation, response) in
                var resData = response as NSData
                
                var countStr:NSString = NSString(data: resData,
                                        encoding: NSUTF8StringEncoding)
                println("\(slideUrl) -> \(countStr)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.hatebuCountLabel.text = "\(countStr) users"
                    self.hatebuCountLabel.hidden = (countStr == "")
                })
            },
            failure: {
                (operaion, error) in
                println(error)
            })
    }
}