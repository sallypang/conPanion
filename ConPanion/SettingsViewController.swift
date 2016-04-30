//
//  SettingsViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingsViewController: UIViewController {
    
    let firebase = Firebase(url: "https://conpanion.firebaseio.com/")
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("email") as! String

            self.userLabel.text = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutAction(sender: UIBarButtonItem) {
        firebase.unauth()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
