//
//  UIAssets.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class UIAssets
{
    struct logoColor
    {
        static var redColor =  UIColor(red: 227.0/255.0, green: 66.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        static var greyColor =  UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    
}

extension UIViewController
{
    func setNavigationAssetsStyle( navigationController : UINavigationController!)
    {
        self.navigationController!.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        //        let border = CALayer()
        //        let width = CGFloat(2.0)
        //        border.borderColor = UIColor.blackColor().CGColor
        //        border.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height - width, width:  self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height )
        //
        //        border.borderWidth = width
        //        self.navigationController!.navigationBar.layer.addSublayer(border)
        //        self.navigationController!.navigationBar.layer.masksToBounds = true
        
        //title font color and size
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }

    
}

extension UITableViewController
{
    func setRefreshControl()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
        self.refreshControl?.tintColor = UIAssets.logoColor.redColor
    }
    
}
