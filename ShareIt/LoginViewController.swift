//
//  LoginViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 11-12-15.
//  Copyright © 2015 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

//static color
//{
//    logoColor
//}

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var viewContainer : UIView!
    
    var isLoggingIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)

        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
        {
        case 0:
            if View.tag == 10
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeTab") as UIViewController
                    
                    viewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                    self.presentViewController(viewController, animated: true, completion: nil)
                })

            }
            
        default: break
        }
    }



    @IBAction func loginButton(sender: AnyObject) {
        
        let username = self.username.text
        let password = self.password.text
        
        if username?.characters.count < 3 {
            let alert = UIAlertView(title: "Error", message: "Submitted username too short", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if password?.characters.count < 8 {
            let alert = UIAlertView(title: "Error", message: "Submitted password too short", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
            
        // Send a request to login
            if (!self.isLoggingIn)
            {
                User.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                    
                    // Stop the spinner
                    spinner.stopAnimating()
                    
                    if ((user) != nil)
                    {
                        if (!self.isLoggingIn)
                        {
                            self.isLoggingIn = true
                            let alert = UIAlertView(title: "Success", message: "Succesfully logged in", delegate: self, cancelButtonTitle: "OK")
                            alert.show()
                            alert.tag = 10
                            
                        }
                        
                        
                    } else {
                        //
                        //                switch (error)
                        //                {
                        //                case   :
                        //                    statement(s);
                        //                    break; /* optional */
                        //                case constant-expression  :
                        //                    statement(s);
                        //                    break; /* optional */
                        //
                        //                    /* you can have any number of case statements */
                        //                default : /* Optional */
                        //                    statement(s);
                        //                }
                        let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                })
            }
                
            }

        
    }
}
