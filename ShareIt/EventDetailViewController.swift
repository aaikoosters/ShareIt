//
//  EventSeeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import MapKit

class EventDetailViewController: UIViewController {

    var receivedEvent: Event!
    var userLoader = ContentLoaderUser()
    
    @IBOutlet weak var userDisplay: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var eventLocation: MKMapView!
        {
        didSet{
            eventLocation.mapType = .Standard
            eventLocation.showsUserLocation = true
            eventLocation.scrollEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pin = MKPointAnnotation()
        pin.coordinate.longitude = receivedEvent.position.longitude
        pin.coordinate.latitude = receivedEvent.position.latitude
        pin.title = receivedEvent.title
        eventLocation.addAnnotation(pin)
    }
    
    override func viewWillAppear(animated: Bool) {
        userDisplay.image = UIImage(named: "logo200")
        self.title = receivedEvent.eventName
        startDate.text = receivedEvent.startDate
        endDate.text = receivedEvent.endDate
        content.text = receivedEvent.content
        
        let location = CLLocation(latitude: receivedEvent.position.latitude, longitude: receivedEvent.position.longitude)
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        eventLocation.setRegion(region, animated: true)
        
        userLoader.findUserById(receivedEvent.user) { (returnUser) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.userName.text = returnUser
            })
            
        }
    }
}
