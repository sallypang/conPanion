//
//  DashboardNavigationController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-27.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class DashboardNavigationController: NavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil) as UIStoryboard
        let controller = storyboard.instantiateViewControllerWithIdentifier("DashboardViewController") as! DashboardViewController
        self.setViewControllers([controller], animated: false)
    }

}
