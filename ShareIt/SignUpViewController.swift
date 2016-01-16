//
//  SingUpViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 11-12-15.
//  Copyright © 2015 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var viewContainer : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.usernameField.delegate = self
        self.passwordField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if email?.characters.count < 1 {
            let alert = UIAlertView(title: "Error", message: "Submitted Emailadress is too short", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if username?.characters.count < 3 {
            let alert = UIAlertView(title: "Error", message: "Username must be at least 3 characters long", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password?.characters.count < 8 {
            let alert = UIAlertView(title: "Error", message: "Password must be at least 8 characters long", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if email?.characters.count < 8 {
            let alert = UIAlertView(title: "Error", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
        newUser.email = finalEmail
        
        // Sign up the user asynchronously
        newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            if ((error) != nil) {
                let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            } else {
                let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigationController")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        })
        }
    }

}
