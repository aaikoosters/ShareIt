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
        
        self.setNavigationAssetsStyle(self.navigationController)
    }
}
