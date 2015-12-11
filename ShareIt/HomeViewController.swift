//
//  HomeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 11-12-15.
//  Copyright © 2015 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.username.text = pUserName
        }
    }
    
}
