//
//  ContentLoaderFriend.swift
//  ShareIt
//
//  Created by Student on 13/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class ContentLoaderFriend
{
    var friends = [User]()
    var currentUser = User.getCurrentUserId()
    
    func loadAllFriends(completion: (returnMessages: [User]) -> Void)
    {
        currentUser = User.getCurrentUserId()
        
        let predicate = NSPredicate(format: "UserID == %@ OR FriendID == %@", currentUser, currentUser)
        
        let subquery = PFQuery(className: "Friend", predicate: predicate)
        
        let isFriend = User.query()
        isFriend!.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: subquery)
        isFriend!.whereKey(User.ObjectId(), notEqualTo: currentUser)
        
        let hasFriend = User.query()
        hasFriend!.whereKey(User.ObjectId(), matchesKey: Friend.userId(), inQuery: subquery)
        hasFriend!.whereKey(User.ObjectId(), notEqualTo: currentUser)
        
        let query = PFQuery.orQueryWithSubqueries([hasFriend!, isFriend!])
        
        self.friends.removeAll()
        
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let user = object as? User
                            {
                                self.friends.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.friends)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    func searchUser(searchText : String ,completion: (returnMessages: [User]) -> Void)
    {
        let subquery = Friend.query()
        subquery?.whereKey(Friend.userId(), containsString: currentUser)
        
        let query = User.query()
        query?.whereKey(User.Username(), containsString: searchText)
        query?.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: subquery!)
        
        
        self.friends.removeAll()
        
        query?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let user = object as? User
                            {
                                self.friends.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.friends)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
}