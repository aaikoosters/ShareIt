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
                    
                    for post in self.posts
                    {
                        self.loadUserForPost(post)
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
    
    func loadUserForPost(message : Message)
    {
        let query1 = User.query()
        query1?.whereKey(User.ObjectId(), equalTo: message.user)
        
        do {
            let users = try query1?.findObjects()
            
            if let objects = users
            {
                message.userObject = objects[0]["username"] as! String
            }

        } catch
        {
            print(error)
        }

        
//        let query = User.query()
//        //        query?.getObjectWithId(<#T##objectId: String##String#>)
//        
//        do
//        {
//            print(message.user)
//            let user = try query?.getObjectWithId(message.user)
//            if let realUser = user as? User
//            {
//                message.userObject = realUser
//            }
//            
//            
//            
//        } catch
//        {
//            print(error)
//        }

        
    }
    
    
    
    
}
