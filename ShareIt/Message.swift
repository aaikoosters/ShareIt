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
    @NSManaged var position: PFGeoPoint
    
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
        return "Message"
    }
    
        
        
//        func iconView() -> UIImageView
//        {
//            let view = PFImageView(imageView: PlaceholderImage)
//            view.file = imageFile
//            view.loadInBackground()
//            return view
//        }

    
//    func fetchTest()
//    {
//        let query = PFQuery(className:"Message")
////        query.whereKey("playerName", equalTo:"Sean Plott")
//        query.findObjectsInBackgroundWithBlock {
//        (objects: [PFObject]?, error: NSError?) -> Void in
//        
//        if error == nil {
//        // The find succeeded.
//        print("Successfully retrieved \(objects!.count) scores.")
//        // Do something with the found objects
//        if let objects = objects {
//        for object in objects {
//        print(object.objectId)
//        }
//        }
//        } else {
//        // Log details of the failure
//        print("Error: \(error!) \(error!.userInfo)")
//        }
//        }
//        
//        
//
//        //subclass queries
//        let query = Armor.query()
//        query.whereKey("rupees", lessThanOrEqualTo: PFUser.currentUser()["rupees"])
//        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
//            if error == nil {
//                if let objects = objects as? [Armor], firstArmor = objects.first {
//                    //...
//                }
//            }
//        }
//
//    }
}

//do {
//}
//catch {
//    print("Error")
//}



//let message = Message()
//message.Content = "test"
//message.User = User.getCurrentUser()?.objectId
//message.saveInBackground()
