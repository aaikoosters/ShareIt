//
//  CoreLocation.swift
//  ShareIt
//
//  Created by Daniello on 12/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocation : NSObject, CLLocationManagerDelegate
{
    override init()
    {
        super.init()
        manager.delegate = self
    }
    var currentLocation = CLLocation()
    var manager = CLLocationManager()


    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse
        {

            dispatch_async(dispatch_get_main_queue(), {
                
                manager.desiredAccuracy = 67.97
                manager.distanceFilter = 10.4
                manager.startUpdatingLocation()
            })


        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation] )
    {
        for location in locations
        {
            if currentLocation.timestamp.compare(location.timestamp) == .OrderedAscending
            {
               currentLocation = location
            }

//            if currentLocation.timestamp.compare(location.timestamp) == .OrderedAscending && end.compare(date) == .OrderedDescending {
//                return true
//            }

        }
    }
    
    
    func loadCurrentLocation(completion: (returnLocation: CLLocation ) -> Void)
    {
        
        completion(returnLocation: self.currentLocation)
    }

    
    
}
