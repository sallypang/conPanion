//
//  LoginViewController.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-29.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let ref = Firebase(url: "https://conpanion.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        ref.observeAuthEventWithBlock { (authData) -> Void in
//            if authData != nil {
////                self.performSegueWithIdentifier("LoginSegue", sender: nil)
//            } else {
//                print("Wrong")
//            }
//        }

    }
    
    @IBAction func loginAction(sender: UIButton) {
        ref.authUser(self.emailTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, auth) in })
    }
    
    @IBAction func signUpAction(sender: UIButton) {
        self.ref.createUser(self.emailTextField.text, password: self.passwordTextField.text) { (error: NSError!) in
            if error == nil {
                self.ref.authUser(self.emailTextField.text, password: self.passwordTextField.text,
                                  withCompletionBlock: { (error, auth) -> Void in
                })
                
                let alertController = UIAlertController(title: "Successful", message: "You've successfully signed up for ConPanion", preferredStyle: .Alert)
                self.presentViewController(alertController, animated: true, completion: nil)
                let delay = 1.0 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid email and password", preferredStyle: .Alert)
                let okOrCancel = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                alertController.addAction(okOrCancel)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
}
