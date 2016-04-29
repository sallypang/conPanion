//
//  EventDetailViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-28.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView?
    @IBOutlet weak var timeLocalLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    var websiteURL: String!
    
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
        let alertController = UIAlertController(title: "Saved to your list", message: "Check out who else is registered!", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
