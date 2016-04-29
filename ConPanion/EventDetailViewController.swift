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
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var timeLocalLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBAction func openURL(sender: UIButton) {
        if let url = NSURL(string: "http://google.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

}
