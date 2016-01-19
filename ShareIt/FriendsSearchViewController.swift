//
//  FriendsSearchViewController.swift
//  ShareIt
//
//  Created by Daniello on 12/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class FriendsSearchViewController: UITableViewController, UISearchBarDelegate
{

    var searchText = "a"
    var selectedUser = User()
    
    @IBOutlet weak var searchBar : UISearchBar!
        {
        didSet
        {
           searchBar.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        userLoader.searchAllNonFriends(searchText) { (returnMessages) -> Void in
            
            self.tableView.reloadData()
        }

    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
        
        userLoader.loadAllNonFriends({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
    }
    

    
    var userLoader = ContentLoaderUser()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        userLoader.loadAllNonFriends({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell  = tableView.dequeueReusableCellWithIdentifier("FriendsSearchCell", forIndexPath: indexPath) as! FriendSearchViewCell
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
