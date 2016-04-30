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

class EventDetailViewController: UIViewController {

    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView?
    @IBOutlet weak var timeLocalLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    var websiteURL: String!
    var eventId: String!
    let usersEvents = Firebase(url: "https://conpanion.firebaseio.com/users/events")
    
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
        
        print(self.descLabel.text)
    }
    
    @IBAction func openURL(sender: UIButton) {
        if let url = NSURL(string: self.websiteURL) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func registerAction(sender: AnyObject) {
        let refChild = self.usersEvents.ref.childByAppendingPath(self.eventId)
        let eventDict: NSDictionary = ["url": self.websiteURL]
        refChild.setValue(eventDict)
        
        let alertController = UIAlertController(title: "Saved to your list", message: "Check out who else is registered!", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
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
}









