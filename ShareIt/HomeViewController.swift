//
//  HomeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 11-12-15.
//  Copyright © 2015 Aaik Oosters. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate
{

    var loader = ContentLoader()
    
    let coreLocation = CoreLocation()
    
    var didCheckPos = false

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        loader.loadAllMessages({
            messages in
            dispatch_async(dispatch_get_main_queue(),{
                    self.addPointsToMap(messages)
            })

        })
        
        coreLocation.loadCurrentLocation({
            location in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    let region = MKCoordinateRegionMakeWithDistance(
                        location.coordinate, 2000, 2000)
                    self.mapView?.setRegion(region, animated: true)
            })
        })
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        switch CLLocationManager.authorizationStatus()
        {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            break
        case .NotDetermined:
            coreLocation.manager.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            let alertController = UIAlertController(
                title: "Location Access Disabled",
                message: "Please open this app's settings and set location access to 'When in use'.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
        dispatch_async(dispatch_get_main_queue(),{
            
//            let region = MKCoordinateRegionMakeWithDistance(
//                self.coreLocation.currentLocation.coordinate, 2000, 2000)
//            self.mapView.setRegion(region, animated: true)
            if (self.didCheckPos == false)
            {
                self.mapView?.setCenterCoordinate(self.coreLocation.currentLocation.coordinate, animated: true)
                self.didCheckPos = true
            }
            

        })

    }
    
    

    override func viewWillDisappear(animated: Bool) {
       // self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.showsUserLocation = true
            
        }
    }

    func addPointsToMap( anotations : [Message])
    {
        mapView.addAnnotations(anotations)
        //mapView.showAnnotations(anotations, animated: true)
    }

    
}
