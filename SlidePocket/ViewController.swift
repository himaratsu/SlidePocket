//
//  ViewController.swift
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reload()
    }

    func reload() -> Void {
        SVProgressHUD.show()
        var api: SlideShareAPI = SlideShareAPI()
        
        // tag search
        api.getSlidesWithTag("swift", self.completion)
        
        // user search
//        api.getSlidesWithUser("himaratsu", {
//            (response, result, error) -> Void in
//            var resultDic: NSDictionary = result as NSDictionary
//            var user: User = resultDic["user"] as User
//            println(user.simpleDescription())
//        })
        
        // query search
//        api.searchSlidesWithQuery("swift", self.completion)
        
    }
    
    // api通信のresponse
    func completion(response: NSHTTPURLResponse? ,result: AnyObject?, error: NSError?) -> Void {
        println("completion ==============================================================================")
        
        println("requestPath is [\(response!.URL.path)]")
        
        // エラーハンドリング
        if let e = error {
            var alert:UIAlertView = UIAlertView()
            alert.title = "エラー"
            alert.message = e.localizedDescription
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return
        }
        
        var resultDic: NSDictionary = result as NSDictionary
        var slides: Array<Slide> = resultDic["slides"] as Array<Slide>

        // 確認のための出力
        for slide:Slide in slides {
            println("slide is [\(slide.simpleDescription())]")
            println("----------------")
        }

    }
    
    @IBAction func reloadBtnTouched(sender : AnyObject) {
        reload()
    }
}

