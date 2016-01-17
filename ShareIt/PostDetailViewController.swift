//
//  PostDetailViewController.swift
//  ShareIt
//
//  Created by Student on 16/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import MapKit
import Parse

class PostDetailViewController : UIViewController
{
    
    @IBOutlet weak var userDisplay: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageLocation: MKMapView!
    {
        didSet{
                messageLocation.mapType = .Standard
                messageLocation.showsUserLocation = true
              }
    }
    @IBOutlet weak var messagetext: UILabel!
    
    var user: PFUser!
    
    var receivedMessage: Message!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        userDisplay.image = UIImage(named: "logo200")
        messagetext.text = receivedMessage.content
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
            {
                do
                {
                    self.user = try PFQuery.getUserObjectWithId(self.receivedMessage.user)
                }
                catch
                {
                    print("Error finding user")
                }
                
                self.userName.text = self.user.username
            })
        
        let location = CLLocation(latitude: receivedMessage.position.latitude, longitude: receivedMessage.position.longitude)
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        messageLocation.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        self.title = receivedMessage.title
        
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = receivedMessage.position.longitude
        pin.coordinate.latitude = receivedMessage.position.latitude
        pin.title = receivedMessage.title
        messageLocation.addAnnotation(pin)
    }
    


    
}