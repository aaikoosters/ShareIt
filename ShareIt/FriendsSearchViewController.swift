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
        userLoader.searchUser(searchText) { (returnMessages) -> Void in
            
            self.tableView.reloadData()
        }

    }
    

    
    var userLoader = ContentLoaderUser()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        userLoader.loadAllUsers({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
        
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell  = tableView.dequeueReusableCellWithIdentifier("FriendsSearchCell", forIndexPath: indexPath)
        let user = userLoader.users[indexPath.row]
        cell.textLabel?.text = user.username
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userLoader.users.count
    }
}
