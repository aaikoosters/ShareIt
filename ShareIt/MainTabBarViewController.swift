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
        self.tabBar.barTintColor = UIAssets.logoColor.greyColor
        self.tabBar.translucent = false
        self.tabBar.tintColor = UIColor.whiteColor()
        
        
        //images in tabbar items
        for controller in self.viewControllers!
        {
            controller.tabBarItem.image = UIImage(named: "message")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            controller.tabBarItem.selectedImage = UIImage(named: "messageRed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
             UITabBar.appearance().tintColor = UIAssets.logoColor.redColor
            
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIAssets.logoColor.redColor], forState:.Selected)
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        }

        
        
    }
    
    
        
        
}
