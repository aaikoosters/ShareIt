

//
//  InviteFriendsViewController.swift
//  ShareIt
//
//  Created by Student on 21/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class InviteFriendsViewController : UITableViewController
{
    var friendList = [User]()
    var userLoader = ContentLoaderUser()
    var selectedUser = User()
    var eventLoader = ContentLoaderEvent()
    var receivedEvent : Event!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRefreshControl()
        self.refreshControl?.beginRefreshing()
        
        self.userLoader.users.removeAll()
        self.tableView.reloadData()
        
        eventLoader.isFriendInvited(receivedEvent) { (returnUsers) -> Void in
            self.friendList = returnUsers
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
       
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("InviteFriendsViewCell", forIndexPath: indexPath) as! InviteFriendsViewCell
        
        if self.friendList.count > 0
        {
            let friend = friendList[indexPath.row]
            cell.userName.text = friend.username
            
            cell.userDisplay.image = UIImage(named: "logo200")
            cell.checkMark.hidden = true
            
            userLoader.loadPhotoForUser(friend.profilePicture!, completion: { (image) -> Void in
                cell.userDisplay.image = UIImage(data:image!)
            })
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.indexPathForSelectedRow?.row
        let friend = self.friendList[selectedCell!]
        eventLoader.addFriendToEvent(friend, currentEvent: receivedEvent)
            { (succeeded) -> Void in
           self.friendList.removeAtIndex(selectedCell!)
                let alert = UIAlertView(title: "Invite", message: "Friend is invited", delegate: self, cancelButtonTitle: "OK")
                alert.show()

                tableView.reloadData()
                
        
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return friendList.count
    }
    
    func startRefresh()
    {
        if self.refreshControl != nil
        {
            self.refreshControl?.beginRefreshing()
            self.refresh(self.refreshControl!)
        }
        
    }
    
    
    func refresh(sender:AnyObject)
    {
        self.refreshControl?.endRefreshing()
    }
}