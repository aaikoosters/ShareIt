//
//  Message.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import Foundation
import Parse

class Message : PFObject, PFSubclassing
{
    @NSManaged var content: String
    @NSManaged var user: String
    @NSManaged var postTitle: String
    @NSManaged var position: PFGeoPoint
    
    var userObject = ""
    
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
    
    static func User() -> String
    {
        return "user"
    }
    
    static func parseClassName() -> String
    {
        return "Message"
    }
    
    func setPosition(latitude : Double, longitudeInput : Double )
    {
        self.position = PFGeoPoint(latitude: latitude, longitude: longitudeInput)
    }
}

