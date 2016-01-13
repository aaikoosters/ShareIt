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
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
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
        let post = postLoader.posts[indexPath.row]
        
        cell.postMesage.text = post.content
        cell.postDisplay.image = UIImage(named: "logo200")
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postLoader.posts.count
    }
    
    


}
