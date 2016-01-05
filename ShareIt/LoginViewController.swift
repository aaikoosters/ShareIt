//
//  LoginViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 11-12-15.
//  Copyright © 2015 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginButton(sender: AnyObject) {
        
        let username = self.username.text
        let password = self.password.text
        
        if username?.characters.count < 3 {
            let alert = UIAlertView(title: "Fout.. ", message: "Gebruikersnaam is te kort", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if password?.characters.count < 8 {
            let alert = UIAlertView(title: "Fout.. ", message: "Wachtwoord is te kort", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        // Send a request to login
        PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            
            if ((user) != nil) {
                let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navHome") as UIViewController
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
                
            } else {
                let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
        }
        
    }
}
