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
    @NSManaged var eventName: String
    @NSManaged var content: String
    @NSManaged var position: PFGeoPoint

    @NSManaged var startDate: String
    @NSManaged var endDate: String
    @NSManaged var viewAble: String
    @NSManaged var user: String
    @NSManaged var eventPicture: PFFile?
    
    //@NSManaged var imageFile: PFFile
    
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
    
    static func User() -> String
    {
        return "user"
    }

    
    static func parseClassName() -> String
    {
        return "Event"
    }
    
    static func nameEvent() -> String
    {
        return "eventName"
    }
    
    static func ViewAble() ->String
    {
        return "viewAble"
    }
    
    func setPosition(latitude : Double, longitudeInput : Double )
    {
        self.position = PFGeoPoint(latitude: latitude, longitude: longitudeInput)
    }
    
}
