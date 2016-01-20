//
//  PostMakeViewController.swift
//  ShareIt
//
//  Created by Daniello on 13/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import UIKit
import MapKit

class PostMakeViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UITextViewDelegate
{
    @IBOutlet weak var titleLabel : UITextField!
    @IBOutlet weak var contentField : UITextView!
    @IBOutlet weak var postButton : UIButton!
    
    let coreLocation = CoreLocation()
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.showsUserLocation = true
            mapView.tintColor = UIAssets.logoColor.redColor
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentField.delegate = self
        self.titleLabel.delegate = self
        
        postButton.addTarget(self, action: "postPressed:", forControlEvents: .TouchUpInside)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationBar = self.navigationController
        {
            self.setNavigationAssetsStyle(self.navigationController)
        }
        
        
        //text area border
        contentField.layer.borderColor = UIAssets.logoColor.greyColor.CGColor
        contentField.layer.cornerRadius = 5
        contentField.layer.borderWidth = 1
        contentField.layer.masksToBounds = true
        
        postButton.layer.cornerRadius = 5
        postButton.layer.masksToBounds = true
        
        activityIndicator.hidden = true
        
        
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
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
        {
        case 0:
            if View.tag == 10
            {
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        default: break
        }
    }
    
    
    func postPressed(sender:UIButton!)
    {
        if !contentField.text.isEmpty && titleLabel.text != nil
        {
            if !titleLabel.text!.isEmpty
            {
                coreLocation.loadCurrentLocation({
                    location in
                    
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            let message = Message()
                            message.user = User.getCurrentUserId()
                            message.postTitle = self.titleLabel.text!
                            message.content = self.contentField.text!
                            message.setPosition(location.coordinate.latitude, longitudeInput: location.coordinate.longitude)
                            
                            self.activityIndicator.startAnimating()
                            self.activityIndicator.hidden = false
                            
                            message.saveInBackgroundWithBlock({ (isComplete, error) -> Void in
                                
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.hidden = true
                                let alert = UIAlertView(title: "Post", message: "Message Posted", delegate: self, cancelButtonTitle: "OK")
                                alert.tag = 10
                                alert.show()
                            })
                    })
                })
                
                
            }
            else
            {
                let alert = UIAlertView(title: "Title", message: "Title cannot be empty", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        else
        {
            let alert = UIAlertView(title: "Message", message: "Message cannot be empty", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    
}
