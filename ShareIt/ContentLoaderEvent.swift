//
//  ContentLoaderEvent.swift
//  ShareIt
//
//  Created by Aaik Oosters on 13-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class ContentLoaderEvent
{
    var events = [Event]()
    
    func loadAllEvents(completion: (returnMessages: [Event]) -> Void)
    {
        let query = Event.query()
        
        self.events.removeAll()
        
        query?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let event = object as? Event
                            {
                                self.events.append(event)
                            }
                        }
                    }
                    completion(returnMessages: self.events)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    func searchEvent(searchText : String ,completion: (returnMessages: [Event]) -> Void)
    {
        let query = Event.query()
        query?.whereKey(Event.nameEvent(), containsString: searchText)
        
        self.events.removeAll()
        
        query?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let event = object as? Event
                            {
                                self.events.append(event)
                            }
                        }
                    }
                    completion(returnMessages: self.events)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    func addFriendToEvent(friend : User!, currentEvent : Event!, completion: (succeeded: Bool) ->Void)
    {
        let invite = Invitation()
        invite.userID = friend.objectId!
        invite.eventID = currentEvent.objectId!
        
        invite.saveInBackgroundWithBlock { (succes, errorProb) -> Void in
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
    
    
    func loadAllFriendsOfEvent(currentEvent : Event!, completion: (returnUsers: [User]) ->Void)
    {
        let invited = Invitation.query()
        invited?.whereKey(Invitation.EventID(), equalTo: currentEvent.objectId!)
    
        var usersReturn = [User]()
        
        invited?.findObjectsInBackgroundWithBlock
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
                                usersReturn.append(user)
                            }
                        }
                    }
                    completion(returnUsers: usersReturn)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    
    func loadAllEventsFriends(completionReturn: (returnMessages: [Event]) -> Void)
    {
        let query = Event.query()
        
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
        
        
        query?.whereKey(Event.User(), matchesKey: User.ObjectId(), inQuery: friends)
        
        
        //////////////////////////
        self.events.removeAll()
        
        query?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let event = object as? Event
                            {
                                self.events.append(event)
                            }
                        }
                    }
                    completionReturn(returnMessages: self.events)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    
    
    func loadAllMyEvents(completion: (returnMessages: [Event]) -> Void)
    {
        let queryMyEvents = Event.query()
        
        let currentUser = User.getCurrentUserId()
        queryMyEvents?.whereKey(Event.User(), equalTo: currentUser)
        
        queryMyEvents?.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let objects = objects
                    {
                        for object in objects
                        {
                            if let event = object as? Event
                            {
                                if  !self.events.contains(event)
                                {
                                    self.events.append(event)
                                }
                                
                            }
                        }
                    }
                    completion(returnMessages: self.events)
                }
                else
                {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
        
    }
    
    func loadAllEventsinRangeFriends(userLatitude: Double, userlongitude: Double, range : Int ,completion: (returnMessages: [Event]) -> Void)
    {
        
        loadAllEventsFriends { (returnMessages) -> Void in
            
            self.loadAllMyEvents({ (returnMessages) -> Void in
                
                let query = Event.query()
                
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
                                    if let event = object as? Event
                                    {
                                        if  !self.events.contains(event)
                                        {
                                            self.events.append(event)
                                        }
                                        
                                    }
                                }
                            }
                            
                                completion(returnMessages: self.events)

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


    
    
    
}

