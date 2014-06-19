//
//  ViewController.swift
//  SlidePocket
//
//  Created by Ryosuke Hiramatsu on 2014/06/12.
//  Copyright (c) 2014 rhiramat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView
    var slides: Array<Slide> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 81
        self.reload()
    }

    // ---------------------------------------------
    // UITableViewDelegate, UITableViewDataSource
    // ---------------------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int  {
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return slides.count;
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        var cell: SlideshowCell = tableView .dequeueReusableCellWithIdentifier("Cell") as SlideshowCell
        
        var slide: Slide = slides[indexPath.row]
        cell.titleLabel.text = slide.title
        cell.usernameLabel.text = slide.userName
        
        var q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        var q_main: dispatch_queue_t  = dispatch_get_main_queue()
        
        cell.thumbImageView.image = nil
        dispatch_async(q_global, {
            var imageURL: NSURL = NSURL.URLWithString(slide.thumbnailUrl)
            var imageData: NSData = NSData(contentsOfURL: imageURL)
            
            var image: UIImage = UIImage(data: imageData)
            
            // update ui on main thread
            dispatch_async(q_main, {
                cell.thumbImageView.image = image
                cell.layoutSubviews()
                })
            })
        
        return cell
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var slide: Slide = slides[indexPath.row]
        self.performSegueWithIdentifier("showDetail", sender: slide)
    }
    
    
    // ---------------------------------------------
    // Storyboard
    // ---------------------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "showDetail") {
            var vc:WebViewController = segue.destinationViewController as WebViewController
            vc.slide = sender as? Slide
        }
    }
    
    
    
    // API demos
    func reload() -> Void {
        var api: SlideShareAPI = SlideShareAPI()
        
        // slide by id
//        api.getSlides(slideshowUrl:"http://www.slideshare.net/emilycastor/from-scrappy-to-scale-crafting-earlystage-communities-for-culture-and-growth", completion: {
//            (response, result, error) -> Void in
//            var resultDic: NSDictionary = result as NSDictionary
//            var slide: Slide = resultDic["slide"] as Slide
//            println(slide.simpleDescription())
//        })
        
        // tag search
        api.getSlidesWithTag("swift", {
            (response, result, error) -> Void in
            var resultDic: NSDictionary = result as NSDictionary
            var slides: Array<Slide> = resultDic["slides"] as Array<Slide>
            var tag: Tag = resultDic["tag"] as Tag
            
            self.slides = slides
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            });
        })
        
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
}

