//
//  DashboardViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-27.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import Firebase

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var events = [NSManagedObject]()
    var jsonArray = [[String: AnyObject]]()
    var refresh: UIRefreshControl!
    
    let firebase = Firebase(url: "https://conpanion.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Getting new data...")
        refresh.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresh)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Private Functions
    
    func refresh(sender:AnyObject) {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "DetailSegue") {
            let controller = segue.destinationViewController as! EventDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let event = self.events[indexPath.row]
            controller.nameLabel?.text = String(event.valueForKey("name")!)
            if let description = event.valueForKey("eventDesc") {
//                print("\(description)")
                controller.descLabel?.text = String(description)
            }
            if (event.valueForKey("image") != nil) {
                let url = NSURL(string: String(event.valueForKey("image")!))
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    let data = NSData(contentsOfURL: url!)
                    dispatch_async(dispatch_get_main_queue(), {
                        controller.bgImageView!.image = UIImage(data: data!)
                    });
                }
            }
            controller.websiteURL = String(event.valueForKey("url")!)
        }
    }
    
    //MARK: JSONParsing
    
    func getData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        Alamofire.request(.GET, "https://www.eventbriteapi.com/v3/events/search/?popular=true&token=HY3HXU4E5U7IRDLYSHA6") .responseJSON { response in
            if ((response.result.value) != nil) {
                let jsonVar = JSON(response.result.value!)
                self.jsonArray = jsonVar["events"].arrayObject as! [[String: AnyObject]]
               
                for item in self.jsonArray {
                   
                    let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: moc)
                    let event = Event(entity: entity!, insertIntoManagedObjectContext: moc)
                    
                    let eventName = item["name"]!["text"]
                    let eventDescription = item["description"]!["text"]
                    let startLocal = item["start"]!["local"]
                    let startTimezone = item["start"]!["timezone"] // required
                    let eventImage = item["logo"]!["url"]
                    
                    event.setValue(eventName, forKey: "name")
                    if !(eventDescription is NSNull) {
                        event.setValue(eventDescription, forKey: "eventDesc")
                    }
                    event.setValue(item["url"], forKey: "url")
                    if (startLocal != nil) {
                        event.setValue(startLocal, forKey:"startLocal")
                    }
                    event.setValue(startTimezone, forKey: "startTimezone")
                    
                    if (eventImage != nil) {
                        event.setValue(eventImage, forKey: "image")
                    }
                   
                    do {
                        try moc.save()
                        self.events.append(event)
                    } catch let error as NSError {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    
                    let refChild = self.firebase.ref.childByAppendingPath("events")
                    let eventDict: NSDictionary = ["name": event.valueForKey("name")!, "url": event.valueForKey("url")!]
                    refChild.setValue(eventDict)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: TableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        let event = self.events[indexPath.row]
        cell.nameLabel.text = String(event.valueForKey("name")!)
        if (event.valueForKey("startLocal") != nil) {
            cell.timeLabel.text = String(event.valueForKey("startLocal")!)
        }
        if (event.valueForKey("image") != nil) {
            let url = NSURL(string: String(event.valueForKey("image")!))
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!)
                dispatch_async(dispatch_get_main_queue(), {
                    cell.bgImageView.contentMode = .ScaleAspectFill
                    cell.bgImageView.image = UIImage(data: data!)
                });
            }
       
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 5.0)
        let view = UIView(frame: frame)
        view.alpha = 0
        return view
    }

}
