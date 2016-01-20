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
    
    
    
    
}

