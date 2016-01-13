//
//  LoginHandler.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import Parse


class UserHandler
{


    class func isUserLoggedIn() -> Bool
    {
        if(User.currentUser() == nil)
        {
            return false
        }
        else
        {
            return true
        }
        
    }
}
