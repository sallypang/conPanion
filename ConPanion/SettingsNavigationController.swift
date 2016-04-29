//
//  SettingsNavigationController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class SettingsNavigationController: NavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Settings", bundle: nil) as UIStoryboard
        let controller = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        self.setViewControllers([controller], animated: false)
    }

}
