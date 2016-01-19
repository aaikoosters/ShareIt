////
////  FriendDetailViewController.swift
////  ShareIt
////
////  Created by Tim Garstman on 17-01-16.
////  Copyright © 2016 Aaik Oosters. All rights reserved.
////

import UIKit

class FriendDetailViewController: UIViewController
{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDisplay: UIImageView!
    
    var friendList = [Friend]()
    var userLoader = ContentLoaderUser()
    var receivedUser: User!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        if receivedUser == nil
        {
            userName.text = "Error"
        } else
        {
            userName.text = receivedUser.username
        }
    }
    
    override func viewDidLoad() {
        
        receivedUser.profilePicture?.getDataInBackgroundWithBlock
            {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        
                        dispatch_async(dispatch_get_main_queue(),
                            {
                                self.userDisplay.image = UIImage(data:imageData)
                        })
                    }
                }
        }
    }
    
    
    
}

// + toevoegen welke posts/events er zijn aangemaakt

// + add friend knop werkend maken

