//
//  PostViewController.swift
//  ShareIt
//
//  Created by Daniello on 12/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class PostViewController: UITableViewController {
    
    var searchText = "a"
    
    var postLoader = ContentLoaderPost()
    var userLoader = ContentLoaderUser()
    
    let coreLocation = CoreLocation()
    
    var selectedMessage: Message!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.postLoader.posts.removeAll()
        self.tableView.reloadData()
        
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
        self.postLoader.posts.removeAll()
        self.tableView.reloadData()
        
        let check = postLoader
        
        if let currentRange =  NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultsKeys.UserDefaultsKey.rangeRegion) as? Int
        {
            postLoader.loadAllPostsinRangeFriends(coreLocation.currentLocation.coordinate.latitude, userlongitude: coreLocation.currentLocation.coordinate.longitude, range: currentRange, completion: { (returnMessages) -> Void in
                if check === self.postLoader
                {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }

            })

        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell  = tableView.dequeueReusableCellWithIdentifier("PostCellView", forIndexPath: indexPath) as! PostViewCell
        
        if self.postLoader.posts.count > 0
        {
            let post = self.postLoader.posts[indexPath.row]
            
            cell.postMesage.text = post.postTitle
            
            cell.postDisplay.image = UIImage(named: "logo200")
            
            userLoader.findWholeUserById(post.user)
                { (returnUser) -> Void in
                if returnUser != nil
                {
                    self.userLoader.loadPhotoForUser(returnUser!.profilePicture, completion: { (image) -> Void in
                        cell.postDisplay.image  = UIImage(data:image!)
                    })
                }
            }

            cell.userName.text = post.userObject
            cell.postBody.text = post.content

        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postLoader.posts.count
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showPostDetail"
        {
            selectedMessage = self.postLoader.posts[self.tableView.indexPathForSelectedRow!.row]
            
            let postDetail = segue.destinationViewController as! PostDetailViewController
            
            postDetail.receivedMessage = selectedMessage
            
            let selectedCell = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow!)! as! PostViewCell
            postDetail.receivedUsername = selectedCell.userName.text
        }
        
    }
    
}
