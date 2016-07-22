//
//  EventDetailViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-28.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import Social
import Firebase

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var websiteURL: String!
    var eventName: String!
    var eventId: String!
    var currentUser: String!
    var eventResourceURI: String!
    var users = [String]()
    var imageString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonView.backgroundColor = UIColor(netHex: 0xfbb029)
        self.ticketsButton.layer.borderWidth = 2.0
        self.ticketsButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.ticketsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.registerButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.registerButton.layer.borderWidth = 2.0
        self.registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

        self.buttonView.layer.zPosition = 1
        self.infoView.layer.zPosition = 1
        
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            let currentUser = snapshot.value.objectForKey("email") as! String
            self.currentUser = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Private Functions
    
    @IBAction func openURL(sender: UIButton) {
        if let url = NSURL(string: self.websiteURL) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func registerAction(sender: AnyObject) {
        let eventString = "https://conpanion.firebaseio.com/events/" + self.eventId + "/users"
        let eventFirebase = Firebase(url: eventString)
    
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let userFirebase = Firebase(url: "https://conpanion.firebaseio.com/users/" + userID + "/events")
        
        let refChild = userFirebase.ref.childByAppendingPath(self.eventId)
        let eventDict: NSDictionary = ["url": self.websiteURL, "name": self.eventName, "imageString": self.imageString]
        refChild.setValue(eventDict)
        
        let eventChild = eventFirebase.ref.childByAppendingPath(userID)
        let userDict: NSDictionary = ["email": self.currentUser]
        eventChild.setValue(userDict)
        
        let alertController = UIAlertController(title: "Saved to your list", message: "Check out who else is registered!", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        eventFirebase.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var newUsers = [String]()
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FDataSnapshot {
                if let name = rest.value["email"] as? String {
                    newUsers.append(name)
                }
            }
            self.users = newUsers
            self.tableView.reloadData()
        })
    }

    @IBAction func shareAction(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let facebookOption = UIAlertAction(title: "Share on Facebook", style: .Default, handler: {(facebookOption: UIAlertAction!) in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                let string = "Going to " + self.websiteURL + " !"
                facebookSheet.setInitialText(string)
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            }
        })
        
        let twitterOption = UIAlertAction(title: "Share on Twitter", style: .Default, handler: {(twitterOption: UIAlertAction!) in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                let string = "Going to " + self.websiteURL + " !"
                twitterSheet.setInitialText(string)
                self.presentViewController(twitterSheet, animated: true, completion: nil)
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(facebookOption)
        alertController.addAction(twitterOption)
        alertController.addAction(cancel)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: TableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! MyEventTableViewCell
        cell.urlLabel.text = self.users[indexPath.row]
        return cell
    }
}









