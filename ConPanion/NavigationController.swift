//
//  NavigationController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-27.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.hidesBottomBarWhenPushed = true
        let font = UIFont(name:"Helvetica", size: 18.0)
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.backIndicatorImage = UIImage.init(named: "BackIcon")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "BackIcon")
        self.navigationBar.translucent = true
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationBar.barTintColor = UIColor(netHex: 0x6193e2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
