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
                messageLocation.scrollEnabled = false
              }
    }
    @IBOutlet weak var messagetext: UILabel!
    
    
    var receivedMessage: Message!
    var receivedUsername: String!
    
    

    
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