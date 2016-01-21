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
                    
                    self.loadUserForPost({ (returnMessages) -> Void in

                        dispatch_async(dispatch_get_main_queue(),{
                            
                             completion(returnMessages: self.posts)
                        })

                    })
                    
                    
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    func loadAllMyPosts(completion: (returnMessages: [Message]) -> Void)
    {
        let queryMyPosts = Message.query()
        
        let currentUser = User.getCurrentUserId()
        queryMyPosts?.whereKey(Message.User(), equalTo: currentUser)
        
        queryMyPosts?.findObjectsInBackgroundWithBlock
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
                                if  !self.posts.contains(message)
                                {
                                    self.posts.append(message)
                                }
                                
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
    
    
    
    func loadAllPostsinRangeFriends(userLatitude: Double, userlongitude: Double, range : Int ,completion: (returnMessages: [Message]) -> Void)
    {
        
        loadAllPostFriends { (returnMessages) -> Void in
            
            self.loadAllMyPosts({ (returnMessages) -> Void in
                
                let query = Message.query()
                
                var doubleRange = Double(range)
                doubleRange = doubleRange / 1000.0
                query?.whereKey("position", nearGeoPoint: PFGeoPoint(latitude: userLatitude, longitude: userlongitude), withinKilometers: doubleRange)
                
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
                                        if  !self.posts.contains(message)
                                        {
                                            self.posts.append(message)
                                        }
                                        
                                    }
                                }
                            }
                            
                            self.loadUserForPost({ (returnMessages) -> Void in
                                
                                dispatch_async(dispatch_get_main_queue(),{
                                    
                                    completion(returnMessages: self.posts)
                                })
                                
                            })
                        }
                        else
                        {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                }
            })
        }
    }
    
     func loadAllPostFriends(completionReturn: (returnMessages: [Message]) -> Void)
     {
        let query = Message.query()
        
        let currentUser = User.getCurrentUserId()
        
        let predicate1 = NSPredicate(format: "UserID == '\(currentUser)' AND accepted == TRUE")
        let predicate2 = NSPredicate(format: "FriendID == %@", currentUser)
        
        let isMyFriendSubquery = PFQuery(className: "Friend", predicate: predicate1)
        let hasMeAsFriendSubquery = PFQuery(className: "Friend", predicate: predicate2)
        
        let isMyFriend = User.query()
        isMyFriend!.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: isMyFriendSubquery)
        
        let hasMeAsFriend = User.query()
        hasMeAsFriend!.whereKey(User.ObjectId(), matchesKey: Friend.userId(), inQuery: hasMeAsFriendSubquery)
        
        let friends = PFQuery.orQueryWithSubqueries([hasMeAsFriend!, isMyFriend!])
        
        
        query?.whereKey(Message.User(), matchesKey: User.ObjectId(), inQuery: friends)

        
        //////////////////////////
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
                    completionReturn(returnMessages: self.posts)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
        

    


    
    
    func loadUserForPost(completionReturn: (returnMessages: [Message]) -> Void)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0))
        {
                for post in self.posts
                {
                    let query1 = User.query()
                    query1?.whereKey(User.ObjectId(), equalTo: post.user)
                    
                    do {
                        let users = try query1?.findObjects()
                        
                        if let objects = users
                        {
                            post.userObject = objects[0]["username"] as! String
                        }
                        
                    } catch
                    {
                        print(error)
                    }
                    
                }
            
            dispatch_async(dispatch_get_main_queue(),{
                
                 completionReturn(returnMessages: self.posts)
            })
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
