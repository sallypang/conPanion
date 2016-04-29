//
//  SettingsViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    let firebase = Firebase(url: "https://conpanion.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutAction(sender: UIBarButtonItem) {
        firebase.unauth()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
