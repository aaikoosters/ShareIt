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
    
    var loader = ContentLoaderPost()
    var userLoader = ContentLoaderUser()
    
    let coreLocation = CoreLocation()
    
    let locateButton = UIButton()
    
    var radiusCircle = MKCircle()
    
    var rangePosts = Int()
    
    var didLoadLoacation = false
    
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
        
 
        
        didLoadLoacation = false
        
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
                mapView.mapType = .Hybrid
            }
        }
        
        if let currentRange = defaults.valueForKey(UserDefaultsKeys.UserDefaultsKey.rangeRegion) as? Int
        {
            self.rangePosts = currentRange
        }
    }
    
    
    func loadLocation()
    {
        coreLocation.loadCurrentLocation({
            location in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    let region = MKCoordinateRegionMakeWithDistance(
                        location.coordinate, 4000, 4000)
                    self.mapView?.setRegion(region, animated: true)
                    
                    self.mapView?.removeOverlays((self.mapView?.overlays)!)
                    self.radiusCircle = MKCircle(centerCoordinate: location.coordinate ,radius:CLLocationDistance(self.rangePosts))
                    self.mapView?.addOverlay(self.radiusCircle)
            })
        })
    }
    
    func reloadPins()
    {
        loader.loadAllPostsinRangeFriends(coreLocation.currentLocation.coordinate.latitude , userlongitude: coreLocation.currentLocation.coordinate.longitude, range: self.rangePosts) { (returnMessages) -> Void in
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.addPointsToMap(returnMessages)
            })
            
        }
 
    }
    
    
    func reloadRange()
    {
        coreLocation.loadCurrentLocation({
            location in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.mapView?.removeOverlays((self.mapView?.overlays)!)
                    self.radiusCircle = MKCircle(centerCoordinate: location.coordinate ,radius:CLLocationDistance(self.rangePosts))
                    self.mapView?.addOverlay(self.radiusCircle)
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
        
        reloadRange()
        
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
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(anotations)
        //mapView.showAnnotations(anotations, animated: true)
    }
    
    
    func locatePressed(sender:UIButton!)
    {
        loadLocation()
        reloadPins()
        
        self.mapView?.removeOverlays((self.mapView?.overlays)!)
        self.radiusCircle = MKCircle(centerCoordinate: coreLocation.currentLocation.coordinate ,radius:CLLocationDistance(self.rangePosts))
        self.mapView?.addOverlay(self.radiusCircle)

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
        if !didLoadLoacation
        {
            self.loadLocation()
            self.reloadPins()
            didLoadLoacation = true
            mapView.tintColor = UIAssets.logoColor.redColor
            
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView!
    {
        if !(annotation is Message)
        {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pointPostMarker")
        
        if view == nil
        {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pointPostMarker")
            
            
            view!.canShowCallout = true
        }
        else
        {
            view?.annotation = annotation
        }
        
        if let mapAnnotation = annotation as? Message
        {
            let viewUI = UIImageView(frame: CGRectMake(0, 0, 40, 40))
            viewUI.image = UIImage(named: "logo200")
            
            userLoader.findWholeUserById(mapAnnotation.user) { (returnUser) -> Void in
                if returnUser != nil
                {
                    self.userLoader.loadPhotoForUser(returnUser!.profilePicture!, completion: { (image) -> Void in
                        viewUI.image = UIImage(data:image!)
                    })
                }
            }
            
            
            view?.leftCalloutAccessoryView = viewUI
            view?.annotation = mapAnnotation
            if let pinView =  view as? MKPinAnnotationView
            {
                if #available(iOS 9.0, *) {
                    //pinView.pinTintColor = UIAssets.logoColor.redColor
                    
                    pinView.pinTintColor = UIColor(red:
                        CGFloat(arc4random_uniform(255))/255.0,
                        green:
                        CGFloat(arc4random_uniform(255))/255.0,
                        blue:
                        CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
     

                } else {
                    pinView.pinColor = MKPinAnnotationColor.Red
                }
            }
            
            
        }
        
        return view
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        if view.gestureRecognizers == nil
        {
            let annotationTap = UITapGestureRecognizer(target: self, action: "annotationPressed:")
            view.addGestureRecognizer(annotationTap)
        }
        else if view.gestureRecognizers?.count == 0
        {
            let annotationTap = UITapGestureRecognizer(target: self, action: "annotationPressed:")
            view.addGestureRecognizer(annotationTap)
        }
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView)
    {
        if view.gestureRecognizers != nil
        {
            view.gestureRecognizers?.removeAll()
        }
    }
    
    func annotationPressed(sender:UITapGestureRecognizer!)
    {
        if let annotationView = sender.view as? MKAnnotationView
        {
            if let customMessage = annotationView.annotation as? Message
            {
                let postDetail = self.storyboard?.instantiateViewControllerWithIdentifier("BerichtZien") as! PostDetailViewController
                postDetail.receivedMessage = customMessage
                self.navigationController?.pushViewController(postDetail, animated: true)
            }
        }
    }

    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView])
    {
        var delayTime = 0
        for view in views
        {
            let mkView = view
            if view.annotation is MKUserLocation {
                continue;
            }
            
            // annotation in view check
            let point:MKMapPoint  =  MKMapPointForCoordinate(mkView.annotation!.coordinate);
            if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point))
            {
                continue;
            }
            
            let endFrame:CGRect = mkView.frame;
            
            // Move annotation out of view
            mkView.frame = CGRectMake(mkView.frame.origin.x, mkView.frame.origin.y - self.view.frame.size.height, mkView.frame.size.width, mkView.frame.size.height);
            
            // Animate drop
            let delay = 0.03 * Double(delayTime)
            UIView.animateWithDuration(0.5, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations:{() in
                mkView.frame = endFrame
                // Animate squash
                }, completion:{(Bool) in
                    UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations:{() in
                        mkView.transform = CGAffineTransformMakeScale(1.0, 0.6)
                        
                        }, completion: {(Bool) in
                            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations:{() in
                                mkView.transform = CGAffineTransformIdentity
                                }, completion: nil)
                    })
                    
            })
            
            delayTime++
        }
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


