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
    @IBOutlet weak var credView: UIView!
    @IBOutlet weak var wrongCredLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.secureTextEntry = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func loginAction(sender: UIButton) {
        DataService.dataService.BASE_REF.authUser(self.emailTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, auth) in
            if error != nil {
                self.shake(self.credView)
                self.wrongCredLabel.hidden = false
            } else {
                self.wrongCredLabel.hidden = true
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! TabBarViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
        })

    }
    
    @IBAction func signUpAction(sender: UIButton) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid email and password", preferredStyle: .Alert)
                let okOrCancel = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                alertController.addAction(okOrCancel)
                self.presentViewController(alertController, animated: true, completion: nil)

            } else {
                DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                    err, authData in
                    
                    let user = ["provider": authData.provider!, "email":email!]
                    
                    DataService.dataService.createNewAccount(authData.uid, user: user)
                })
                
                NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                
                let alertController = UIAlertController(title: "Successful", message: "You've successfully signed up for ConPanion", preferredStyle: .Alert)
                self.presentViewController(alertController, animated: true, completion: nil)
                let delay = 1.0 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        })
    }
    
    //MARK: Private
    func shake(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        view.layer.addAnimation(animation, forKey: "shake")
    }
}
