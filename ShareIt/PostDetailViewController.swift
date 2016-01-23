//
//  PostDetailViewController.swift
//  ShareIt
//
//  Created by Student on 16/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import MapKit

class PostDetailViewController : UIViewController
{
    
    @IBOutlet weak var userDisplay: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageLocation: MKMapView!
    {
        didSet{
                messageLocation.mapType = .Standard
                messageLocation.showsUserLocation = true
                messageLocation.tintColor = UIAssets.logoColor.redColor
              }
    }
    @IBOutlet weak var messagetext: UILabel!
    @IBOutlet weak var titleMessage: UILabel!
    
    
    var receivedMessage: Message!
    var receivedUsername: String!
    var userLoader = ContentLoaderUser()
    
    convenience init(messageInit: Message)
    {
        self.init()
        self.receivedMessage = messageInit
    }

    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        userDisplay.image = UIImage(named: "logo200")
        messagetext.text = receivedMessage.content
        userName.text = receivedUsername
        
        let location = CLLocation(latitude: receivedMessage.position.latitude, longitude: receivedMessage.position.longitude)
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        messageLocation.setRegion(region, animated: true)
        
        titleMessage.text = receivedMessage.title
        
        userLoader.findWholeUserById(receivedMessage.user) { (returnUser) -> Void in
            if returnUser != nil
            {
                self.userName.text = returnUser?.username
                
                
                self.userLoader.loadPhotoForUser(returnUser!.profilePicture, completion: { (image) -> Void in
                    self.userDisplay.image  = UIImage(data:image!)
                })
            }
       
    
    
//        userLoader.findUserById(receivedMessage.user) { (returnUser) -> Void in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.userName.text = returnUser
//                
//                userDisplay.image = UIImage(named: "logo200")
//            })
        
        }
    }
    
    override func viewDidLoad() {
        
        
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = receivedMessage.position.longitude
        pin.coordinate.latitude = receivedMessage.position.latitude
        pin.title = receivedMessage.title
        messageLocation.addAnnotation(pin)
    }
    


    
}