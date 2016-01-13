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
    
    
    
    
}

