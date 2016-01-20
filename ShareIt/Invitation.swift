//
//  Invitation.swift
//  ShareIt
//
//  Created by Daniello on 20/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class Invitation : PFObject, PFSubclassing
{
    
    @NSManaged var eventID: String
    @NSManaged var userID: String
    
    static func UserId() -> String
    {
        return "userID"
    }
    
    static func EventID() ->String
    {
        return "eventID"
    }

    
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
    
    static func parseClassName() -> String
    {
        return "Invitation"
    }
}
