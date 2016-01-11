//
//  User.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class User  : PFUser
{
    @NSManaged var name: String?
    @NSManaged var surname: String?
    @NSManaged var phoneNumber: String?
    
    override class func initialize()
    {
        struct Static
        {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken)
            {
                self.registerSubclass()
        }
    }
    
    class func getCurrentUser() -> User?
    {
        return PFUser.currentUser() as? User
    }
}