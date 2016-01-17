//
//  PostDetailViewController.swift
//  ShareIt
//
//  Created by Student on 16/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import CoreLocation

class PostDetailViewController : UIViewController
{
    
    @IBOutlet weak var userDisplay: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var messagetext: UILabel!
    
    
    var receivedMessage: Message!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        userDisplay.image = UIImage(named: "logo200")
        userName.text = receivedMessage.user
        messagetext.text = receivedMessage.content

    }
    
    
}