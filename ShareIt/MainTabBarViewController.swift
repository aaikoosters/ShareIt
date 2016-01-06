//
//  MainTabBarViewController.swift
//  ShareIt
//
//  Created by Daniello on 06/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController
{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.barTintColor = logoColor.greyColor
        self.tabBar.translucent = false
        self.tabBar.tintColor = UIColor.whiteColor()
        
        
        
    }
    
    
        
        
}
