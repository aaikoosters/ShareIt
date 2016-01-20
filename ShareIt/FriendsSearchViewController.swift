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
    
    
    var userLoader = ContentLoaderUser()
    
    @IBOutlet weak var searchBar : UISearchBar!
        {
        didSet
        {
           searchBar.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        self.refreshControl?.beginRefreshing()
        
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        
        self.userLoader.users.removeAll()
        self.tableView.reloadData()
        

        userLoader.searchAllNonFriends(searchText) { (returnMessages) -> Void in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
        
        startRefresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRefreshControl()
        startRefresh()

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
        self.userLoader.users.removeAll()
        self.tableView.reloadData()
        
        userLoader.loadAllNonFriends({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.refreshControl?.endRefreshing()
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
