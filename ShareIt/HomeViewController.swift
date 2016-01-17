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
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        locateButton.setImage( UIImage(named:"location"), forState: .Normal)
        locateButton.frame.size = CGSize(width: 40.0, height: 40.0)
        
        //        locateButton.center = CGPoint(x: self.view.frame.size.width - (locateButton.frame.size.width/2) - 20, y: self.navigationController!.navigationBar.frame.size.height -  self.navigationController!.navigationBar.frame.size.height - (locateButton.frame.size.height/2))
        
        locateButton.center = self.view .convertPoint(self.view.center, fromView: self.view)
        
        //        let xConstraint = NSLayoutConstraint(item: locateButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.mapView, attribute: .CenterX, multiplier: 1, constant: 0)
        //
        //        let yConstraint = NSLayoutConstraint(item: locateButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.mapView, attribute: .CenterY, multiplier: 1, constant: 0)
        //
        //        self.locateButton.addConstraint(xConstraint)
        //        self.locateButton.addConstraint(yConstraint)
        
        
        self.view.addSubview(locateButton)
        
        locateButton.addTarget(self, action: "locatePressed:", forControlEvents: .TouchUpInside)
        
        
        
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
            mapView.mapType = .Standard
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
    
    
    
}

