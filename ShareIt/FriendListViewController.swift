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
    var friendList = [Friend]()
    var userLoader = ContentLoaderUser()
    var selectedUser = User()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        
        userLoader.loadAllFriends({
            users in
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.tableView.reloadData()
                    
            })
        })
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendListViewCell", forIndexPath: indexPath) as! FriendListViewCell
        
        if self.userLoader.users.count > 0
        {
            let friend = userLoader.users[indexPath.row]
            cell.userName.text = friend.username
            
                
                                userLoader.loadPhotoForUser(friend.profilePicture!, completion: { (image) -> Void in
                                    cell.userDisplay.image = UIImage(data:image!)
                                })
            
                            
        }
    
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userLoader.users.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showUserDetail"
        {
            selectedUser = self.userLoader.users[self.tableView.indexPathForSelectedRow!.row]
            
            let friendDetail = segue.destinationViewController as! FriendDetailViewController
            
            friendDetail.receivedUser = selectedUser
            
        }
        
    }
}
