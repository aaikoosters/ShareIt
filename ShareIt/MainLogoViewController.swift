//
//  MainLogoViewController.swift
//  ShareIt
//
//  Created by Daniello on 04/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

struct logoColor
{
    static var redColor =  UIColor(red: 252.0/255.0, green: 86.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    static var greyColor =  UIColor(red: 126.0/255.0, green: 43.0/255.0, blue: 34.0/255.0, alpha: 1.0)
}

class MainLogoViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        

        
        
        self.navigationItem.title = "Home"
        if (PFUser.currentUser() != nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeTab")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        super.viewWillDisappear(animated)
    }

    
}
