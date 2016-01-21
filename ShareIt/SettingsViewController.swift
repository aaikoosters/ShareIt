//
//  SettingsViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 05-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userDisplay: UIImageView!
    
    var userLoader = ContentLoaderUser()
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        
        
        // Send a request to log out a user
        User.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigationController") as UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.userName.text = pUserName
            

            userLoader.loadPhotoForUser(PFUser.currentUser()!["profilePicture"] as? PFFile, completion: { (image) -> Void in
                    self.userDisplay.image = UIImage(data:image!)
            })

        }

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
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationAssetsStyle(self.navigationController)
    }

}
