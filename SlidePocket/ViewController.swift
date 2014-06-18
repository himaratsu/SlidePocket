//
//  ViewController.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/12.
//  Copyright (c) 2014 rhiramat. All rights reserved.
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
        
        // slide by id
        api.getSlides(slideshowUrl:"http://www.slideshare.net/emilycastor/from-scrappy-to-scale-crafting-earlystage-communities-for-culture-and-growth", completion: {
            (response, result, error) -> Void in
            var resultDic: NSDictionary = result as NSDictionary
            var slide: Slide = resultDic["slide"] as Slide
            println(slide.simpleDescription())
        })
        
        // tag search
//        api.getSlidesWithTag("swift", {
//            (response, result, error) -> Void in
//            var resultDic: NSDictionary = result as NSDictionary
//            var slides: Array<Slide> = resultDic["slides"] as Array<Slide>
//            var tag: Tag = resultDic["tag"] as Tag
//            
//            // 確認のための出力
//            for slide:Slide in slides {
//                println("slide is [\(slide.simpleDescription())]")
//                println("----------------")
//            }
//            
//            println("tag is \(tag.simpleDescription())")
//        })
        
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

