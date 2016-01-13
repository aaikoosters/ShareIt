//
//  ContentLoaderPost.swift
//  ShareIt
//
//  Created by Daniello on 13/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import Foundation
import Parse

class ContentLoaderPost
{
    var posts = [Message]()
    
    func loadAllPosts(completion: (returnMessages: [Message]) -> Void)
    {
        let query = Message.query()
        
        self.posts.removeAll()
        
        query?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let message = object as? Message
                            {
                                self.posts.append(message)
                            }
                        }
                    }
                    completion(returnMessages: self.posts)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
}
