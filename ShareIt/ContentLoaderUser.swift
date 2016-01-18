//
//  ContentLoaderUser.swift
//  ShareIt
//
//  Created by Daniello on 12/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class ContentLoaderUser
{
    var users = [User]()
    var currentUser = User.getCurrentUserId()
    
    func loadAllUsers(completion: (returnMessages: [User]) -> Void)
    {
        let query = User.query()
        
        self.users.removeAll()
        
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
                                self.users.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.users)
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
        let query = User.query()
        query?.whereKey(User.Username(), containsString: searchText)
        
        self.users.removeAll()
        
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
                                self.users.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.users)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }

    func loadAllFriends(completion: (returnMessages: [User]) -> Void)
    {
        currentUser = User.getCurrentUserId()
        
        let predicate1 = NSPredicate(format: "UserID == %@", currentUser)
        let predicate2 = NSPredicate(format: "FriendID == %@", currentUser)
        
        let isMyFriendSubquery = PFQuery(className: "Friend", predicate: predicate1)
        let hasMeAsFriendSubquery = PFQuery(className: "Friend", predicate: predicate2)
        
        let isMyFriend = User.query()
        isMyFriend!.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: isMyFriendSubquery)
        
        let hasMeAsFriend = User.query()
        hasMeAsFriend!.whereKey(User.ObjectId(), matchesKey: Friend.userId(), inQuery: hasMeAsFriendSubquery)
        
        let query = PFQuery.orQueryWithSubqueries([hasMeAsFriend!, isMyFriend!])
        
        self.users.removeAll()
        
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
                                self.users.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.users)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    func loadAllNonFriends(completion: (returnMessages: [User]) -> Void)
    {
        currentUser = User.getCurrentUserId()
        
        let predicate1 = NSPredicate(format: "UserID == %@", currentUser)
        let predicate2 = NSPredicate(format: "FriendID == %@", currentUser)
        
        let isMyFriendSubquery = PFQuery(className: "Friend", predicate: predicate1)
        let hasMeAsFriendSubquery = PFQuery(className: "Friend", predicate: predicate2)
        
        let isMyFriend = User.query()
        isMyFriend!.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: isMyFriendSubquery)
        
        let hasMeAsFriend = User.query()
        hasMeAsFriend!.whereKey(User.ObjectId(), matchesKey: Friend.userId(), inQuery: hasMeAsFriendSubquery)
        
        let friends = PFQuery.orQueryWithSubqueries([hasMeAsFriend!, isMyFriend!])
        
        let nonFriends = User.query()
        nonFriends?.whereKey(User.ObjectId(), doesNotMatchKey: User.ObjectId(), inQuery: friends)
        nonFriends?.whereKey(User.ObjectId(), notEqualTo: currentUser)
        
        self.users.removeAll()
        
        nonFriends!.findObjectsInBackgroundWithBlock
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
                                self.users.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.users)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    func addFriend(mainUser : String , friendUser : String , completion: (returnMessages: [User]) -> Void)
    {
        
    }
    
    
    func searchAllNonFriends(searchText: String, completion: (returnMessages: [User]) -> Void)
    {
        currentUser = User.getCurrentUserId()
        
        let predicate1 = NSPredicate(format: "UserID == %@", currentUser)
        let predicate2 = NSPredicate(format: "FriendID == %@", currentUser)
        
        let isMyFriendSubquery = PFQuery(className: "Friend", predicate: predicate1)
        let hasMeAsFriendSubquery = PFQuery(className: "Friend", predicate: predicate2)
        
        let isMyFriend = User.query()
        isMyFriend!.whereKey(User.ObjectId(), matchesKey: Friend.friendId(), inQuery: isMyFriendSubquery)
        
        let hasMeAsFriend = User.query()
        hasMeAsFriend!.whereKey(User.ObjectId(), matchesKey: Friend.userId(), inQuery: hasMeAsFriendSubquery)
        
        let friends = PFQuery.orQueryWithSubqueries([hasMeAsFriend!, isMyFriend!])
        
        let nonFriends = User.query()
        nonFriends?.whereKey(User.ObjectId(), doesNotMatchKey: User.ObjectId(), inQuery: friends)
        nonFriends?.whereKey(User.ObjectId(), notEqualTo: currentUser)
        nonFriends?.whereKey(User.Username(), containsString: searchText)
        
        self.users.removeAll()
        
        nonFriends!.findObjectsInBackgroundWithBlock
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
                                self.users.append(user)
                            }
                        }
                    }
                    completion(returnMessages: self.users)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
}

