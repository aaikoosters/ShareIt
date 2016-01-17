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
    
    var selectedMessage: Message!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        self.postLoader.posts.removeAll()
        self.tableView.reloadData()
        
        postLoader.loadAllPosts({
            posts in
            dispatch_async(dispatch_get_main_queue(),{
                
                self.tableView.reloadData()
            })
        })

        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell  = tableView.dequeueReusableCellWithIdentifier("PostCellView", forIndexPath: indexPath) as! PostViewCell
        let post = self.postLoader.posts[indexPath.row]
        
        cell.postMesage.text = post.content
        cell.postDisplay.image = UIImage(named: "logo200")
        cell.userName.text = post.userObject
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postLoader.posts.count
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        selectedMessage = self.postLoader.posts[self.tableView.indexPathForSelectedRow!.row]
        
        let postDetail = segue.destinationViewController as! PostDetailViewController
        
        postDetail.receivedMessage = selectedMessage
    }

}
