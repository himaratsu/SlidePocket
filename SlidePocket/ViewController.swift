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
        api.getSlidesWitgTag("swift", self.completion)
    }
    
    // api通信のresponse
    func completion(result: AnyObject?, error: NSError?) -> Void {
        // エラーハンドリング
        if let e = error {
            var alert:UIAlertView = UIAlertView()
            alert.title = "エラー"
            alert.message = e.localizedDescription
            alert.addButtonWithTitle("OK")
            alert.show()
            
            return
        }
        println("result int ViewController!: \(result)")
    }
    
    @IBAction func reloadBtnTouched(sender : AnyObject) {
        reload()
    }
}

