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
        
        let predicate1 = NSPredicate(format: "UserID == '\(currentUser)' AND accepted == TRUE")
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
    
    func findUserById(userId: String, completion: (returnUser: String?) ->Void)
    {
        var user: String?
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
            {
                do
                {
                    user = try PFQuery.getUserObjectWithId(userId)["username"] as? String
                }
                catch
                {
                    print("Error finding user")
                }
                
                completion(returnUser: user)
        })
    }
    
    func findWholeUserById(userId: String, completion: (returnUser: User?) ->Void)
    {
        var returnUser = User?()
        
        currentUser = User.getCurrentUserId()
        
 
        if userId == currentUser
        {
            returnUser = UserHandler.getCurrentUser()
            
            completion(returnUser: returnUser)
        }
        else
        {
            let userQuery = User.query()
            userQuery?.whereKey(User.ObjectId(), equalTo: userId)
                
                userQuery?.findObjectsInBackgroundWithBlock
                {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if error == nil
                    {
                        if let objects = objects
                        {
                            for object in objects
                            {
                                if let userElement = object as? User
                                {
                                    returnUser = userElement
                                }
                            }
                        }
                       completion(returnUser: returnUser)
                    }
                    else
                    {
                        // Log details of the failure
                        print("Error: \(error!) \(error!.userInfo)")
                    }
            }

            
        }

    }
    
    
    
    func findWhatUserIs(searchUser : User , completion: (friends : [Friend?]) -> Void)
    {
        print(currentUser)
        print(searchUser.objectId)
        let predicate1 = NSPredicate(format: "UserID == '\(currentUser)' AND FriendID == '\(searchUser.objectId!)'")
        let predicate2 = NSPredicate(format: "FriendID == '\(currentUser)' AND UserID == '\(searchUser.objectId!)'")
        
        let isMyFriendSubquery = PFQuery(className: "Friend", predicate: predicate1)
        let hasMeAsFriendSubquery = PFQuery(className: "Friend", predicate: predicate2)
        
        let friends = PFQuery.orQueryWithSubqueries([isMyFriendSubquery, hasMeAsFriendSubquery])
        
        var friendsArray = [Friend?]()
        
        friends.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let friendElement = object as? Friend
                            {
                                friendsArray.append(friendElement)
                            }
                        }
                    }
                    completion(friends: friendsArray)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    func addFriendForUser(friend : User!, completion: (succeeded: Bool) ->Void)
    {
        let friendMake = Friend()
        friendMake.UserID = currentUser
        friendMake.FriendID = friend.objectId!
        friendMake.accepted = false
        
        friendMake.saveInBackgroundWithBlock { (succes, errorProb) -> Void in
            if succes
            {
                completion(succeeded: true)
            }
            else
            {
                completion(succeeded: false)
            }
        }
    }
    
     func deleteFriend(friendRel : Friend!, completion: (succeeded: Bool) ->Void)
     {
        friendRel.deleteInBackgroundWithBlock { (succes, errorName) -> Void in
            
            if succes
            {
                completion(succeeded: true)
            }
            else
            {
                completion(succeeded: false)
            }
        }
    }
    
    func confirmFriend(friendRel : Friend!, completion: (succeeded: Bool) ->Void)
    {
        friendRel.accepted = true
        friendRel.saveInBackgroundWithBlock { (succes, errorProb) -> Void in
            if succes
            {
                completion(succeeded: true)
            }
            else
            {
                completion(succeeded: false)
            }
        }

    }
    
    func loadPhotoForUser (photoFile: PFFile?, completion: (image: NSData?) ->Void)
    {
        if let photo =  photoFile
        {
            photo.getDataInBackgroundWithBlock
                {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            
                            dispatch_async(dispatch_get_main_queue(),
                                {
                                    completion(image: imageData)
                            })
                        }
                    }
            }

            
        }
        else
        {
            
        }
        
    }
    
    
}

