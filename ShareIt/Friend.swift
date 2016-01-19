//
//  Friend.swift
//  ShareIt
//
//  Created by Student on 06/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class Friend : PFObject, PFSubclassing
{
    var friends = [User]()
    
    @NSManaged var UserID: String
    @NSManaged var FriendID: String
    @NSManaged var accepted: Bool
    
    static func userId() -> String
    {
        return "UserID"
    }
    
    static func friendId() ->String
    {
        return "FriendID"
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
        return "Friend"
    }
}