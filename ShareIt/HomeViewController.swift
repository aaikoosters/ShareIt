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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }

    
    override func viewWillDisappear(animated: Bool) {
        
        
       // self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        super.viewWillDisappear(animated)
    }

    
}
