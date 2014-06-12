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

        reload()
    }

    func reload() -> Void {
        var api: SlideShareAPI = SlideShareAPI()
        api.getSlidesWitgTag("ios")
    }

    @IBAction func reloadBtnTouched(sender : AnyObject) {
        reload()
    }
}

