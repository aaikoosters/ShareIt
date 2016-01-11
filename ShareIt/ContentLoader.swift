//
//  ContentLoader.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class ContentLoader
{
    var messages = [Message]()
    
    func loadAllMessages(completion: (returnMessages: [Message]) -> Void)
    {
        let query = Message.query()
        
        
        query?.findObjectsInBackgroundWithBlock
        {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil
            {
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        if let message = object as? Message
                        {
                            self.messages.append(message)
                        }

                    }
                }
                
                completion(returnMessages: self.messages)
            }
            else
            {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}
