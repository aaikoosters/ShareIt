//
//  FriendListViewController.swift
//  ShareIt
//
//  Created by Daniello on 06/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class FriendListViewController: UITableViewController
{
    var friendList = FriendList()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
}
