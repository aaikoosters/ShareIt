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
    @IBOutlet weak var buttonControl: UIButton!
    
    var friendList = [Friend?]()
    var userLoader = ContentLoaderUser()
    var receivedUser: User!
    var actionPerformed = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        if receivedUser == nil
        {
            userName.text = "Error"
            buttonControl.hidden = true
        } else
        {
            userName.text = receivedUser.username
            userLoader.findWhatUserIs(receivedUser, completion: {
                (friends) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.friendList = friends
                    
                    if friends.count == 0
                    {
                        //self.buttonControl.backgroundColor = UIColor.redColor()
                        self.buttonControl.setImage( UIImage(named: "add"), forState: UIControlState.Normal)
                        self.buttonControl.addTarget(self, action: "addFriend:", forControlEvents: .TouchUpInside)
                        
                    }
                    else
                    {
                        if let friend = friends[0]
                        {
                            if friend.accepted
                            {
                                //self.buttonControl.backgroundColor = UIColor.brownColor()
                                self.buttonControl.setImage( UIImage(named: "delete"), forState: UIControlState.Normal)
                                self.buttonControl.addTarget(self, action: "deleteFriend:", forControlEvents: .TouchUpInside)
                                
  
                            }
                            else
                            {
                                //self.buttonControl.backgroundColor = UIColor.blueColor()
                                self.buttonControl.setImage( UIImage(named: "confirm"), forState: UIControlState.Normal)
                                self.buttonControl.addTarget(self, action: "confirmFriend:", forControlEvents: .TouchUpInside)
                                
                            }
                        }
                        
                    }
                    
                })
            })
        }
    }
    
    func addFriend(sender:UIButton!)
    {
        if actionPerformed
        {
            return
        }
        self.actionPerformed = true
        userLoader.addFriendForUser(receivedUser) { (succeded) -> Void in
            if succeded
            {
                let alert = UIAlertView(title: "Friend", message:"Friend request sent", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                alert.tag = 20
                


               
            }
            else
            {
                let alert = UIAlertView(title: "Friend", message:"Could not send friend request", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                self.actionPerformed = false
            }
            
        }
        
    }
    
    func deleteFriend(sender:UIButton!)
    {
        if actionPerformed
        {
            return
        }
        self.actionPerformed = true

        if let friend = self.friendList[0]
        {
            userLoader.deleteFriend(friend) { (succeded) -> Void in
                
                if succeded
                {
                    let alert = UIAlertView(title: "Friend", message:"Friend was deleted", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    alert.tag = 10
                }
                else
                {
                    let alert = UIAlertView(title: "Friend", message:"Could not delete friend", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.actionPerformed = false
                }
            }
        }
        
    }
    
    func confirmFriend(sender:UIButton!)
    {
        if actionPerformed
        {
            return
        }
        self.actionPerformed = true

        if let friend = self.friendList[0]
        {
            userLoader.confirmFriend(friend) { (succeded) -> Void in
                
                if succeded
                {
                    let alert = UIAlertView(title: "Friend", message:"Friend was added", delegate: self, cancelButtonTitle: "OK")
                    alert.tag = 10
                    alert.show()
                
                }
                else
                {
                    let alert = UIAlertView(title: "Friend", message:"Could not add friend", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.actionPerformed = false
                }
            }
        }

    }
    
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
        {
        case 0:
            if View.tag == 10
            {
                self.navigationController?.popViewControllerAnimated(true)
                
                if let viewcontrollers = self.navigationController?.viewControllers
                {
                    for controller in viewcontrollers
                    {
                        if let friendListController = controller as? FriendListViewController
                        {
                            friendListController.startRefresh()
                        }
                    }
                }
            }
            else if View.tag == 20
            {
                self.navigationController?.popViewControllerAnimated(true)
                
                if let viewcontrollers = self.navigationController?.viewControllers
                {
                    for controller in viewcontrollers
                    {
                        if let friendListController = controller as? FriendsSearchViewController
                        {
                            friendListController.startRefresh()
                        }
                    }
                }
            }
            
        default: break
        }
    }
    

    
    override func viewDidLoad() {
        
        self.userDisplay.image = UIImage(named: "logo200")
        userLoader.loadPhotoForUser(receivedUser.profilePicture, completion: { (image) -> Void in
            self.userDisplay.image = UIImage(data:image!)
        })
    }
    
    
    
}

// + toevoegen welke posts/events er zijn aangemaakt

// + add friend knop werkend maken

