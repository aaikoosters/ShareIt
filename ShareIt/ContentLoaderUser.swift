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

    
    
    
}

