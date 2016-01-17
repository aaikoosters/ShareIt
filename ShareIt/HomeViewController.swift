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
    
    let locateButton = UIButton()
    
    var radiusCircle = MKCircle()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        locateButton.setImage( UIImage(named:"location"), forState: .Normal)
        locateButton.frame.size = CGSize(width: 4.0, height: 4.0)
        
        locateButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.mapView.addSubview(locateButton)
        
        //layout constraint button
        
        let xConstraint = NSLayoutConstraint(item: locateButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.mapView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -10)
        
        let yConstraint = NSLayoutConstraint(item: locateButton, attribute:  NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.mapView, attribute:  NSLayoutAttribute.Bottom, multiplier: 1, constant: -10)
        
        let sizeX = NSLayoutConstraint(item: locateButton, attribute:  NSLayoutAttribute.Width, relatedBy: .Equal, toItem: locateButton, attribute:  NSLayoutAttribute.Width, multiplier: 1, constant: 2)
        
        let sizeY = NSLayoutConstraint(item: locateButton, attribute:  NSLayoutAttribute.Height, relatedBy: .Equal, toItem: locateButton, attribute:  NSLayoutAttribute.Height, multiplier: 1, constant: 2)
        
        self.locateButton.addConstraint(sizeX)
        self.locateButton.addConstraint(sizeY)
        
        
        self.mapView.addConstraint(xConstraint)
        self.mapView.addConstraint(yConstraint)
        
        locateButton.addTarget(self, action: "locatePressed:", forControlEvents: .TouchUpInside)
  
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let selected = defaults.valueForKey(UserDefaultsKeys.UserDefaultsKey.mapType) as? Bool
        {
            if selected
            {
                mapView.mapType = .Standard
            }
            else
            {
                mapView.mapType = .Satellite
            }
        }

        
        loader.loadAllMessages({
            messages in
            dispatch_async(dispatch_get_main_queue(),{
                self.addPointsToMap(messages)
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
        
        coreLocation.loadCurrentLocation({
            location in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    let region = MKCoordinateRegionMakeWithDistance(
                        location.coordinate, 4000, 4000)
                    self.mapView?.setRegion(region, animated: true)
                    
                    self.mapView?.removeOverlay(self.radiusCircle)
                    self.radiusCircle = MKCircle(centerCoordinate: location.coordinate ,radius:CLLocationDistance(1000))
                    self.mapView?.addOverlay(self.radiusCircle)
            })
        })
        
    }
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
        // self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
            
        }
    }
    
    func addPointsToMap( anotations : [Message])
    {
        mapView.addAnnotations(anotations)
        //mapView.showAnnotations(anotations, animated: true)
    }
    
    
    func locatePressed(sender:UIButton!)
    {
        coreLocation.loadCurrentLocation({
            location in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    let region = MKCoordinateRegionMakeWithDistance(
                        location.coordinate, 4000, 4000)
                    self.mapView?.setRegion(region, animated: true)
                    
                    self.radiusCircle = MKCircle(centerCoordinate: location.coordinate ,radius:CLLocationDistance(1000))
                    
            })
        })
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {
        
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIAssets.logoColor.redColor.colorWithAlphaComponent(0.07)
        circleRenderer.strokeColor = UIAssets.logoColor.redColor
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
        self.mapView?.removeOverlays((self.mapView?.overlays)!)
        self.radiusCircle = MKCircle(centerCoordinate: userLocation.coordinate ,radius:CLLocationDistance(1000))
        self.mapView?.addOverlay(self.radiusCircle)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "HomeMapSettingsTransition"
        {
            if let settingsView = segue.destinationViewController as? HomeSettingViewcontroller
            {

            }
        }


    }

    
    
    
}

