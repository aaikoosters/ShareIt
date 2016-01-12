//
//  Event.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse

class Event : PFObject, PFSubclassing
{
    @NSManaged var content: String
    @NSManaged var position: PFGeoPoint
    @NSManaged var startDate: NSDate
    
    @NSManaged var imageFile: PFFile
    
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
        return "Event"
    }
    
}
