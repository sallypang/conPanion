//
//  MyConcertsNavigationController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class MyConcertsNavigationController: NavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "MyConcerts", bundle: nil) as UIStoryboard
        let controller = storyboard.instantiateViewControllerWithIdentifier("MyConcertsViewController") as! MyConcertsViewController
        self.setViewControllers([controller], animated: false)
    }

}
