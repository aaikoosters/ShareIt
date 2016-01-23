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
        self.tabBar.barTintColor = UIColor.clearColor()
        self.tabBar.translucent = false

        UITabBar.appearance().tintColor = UIAssets.logoColor.redColor
         UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIAssets.logoColor.redColor], forState:.Selected)
        //images in tabbar items
//        for controller in self.viewControllers!
//        {
////            controller.tabBarItem.image = UIImage(named: "message")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
////            
////            controller.tabBarItem.selectedImage = UIImage(named: "messageRed")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//
//           
//        }

        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIAssets.logoColor.redColor.CGColor
        border.frame = CGRect(x: 0, y: 0 , width:  self.tabBar.frame.size.width , height: width )
        
        border.borderWidth = width
        self.tabBar.layer.addSublayer(border)
        self.tabBar.layer.masksToBounds = true

    }
    
    
        
        
}
