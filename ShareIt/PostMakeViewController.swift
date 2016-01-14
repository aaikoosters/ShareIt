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
    
    
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.showsUserLocation = true
            
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
        
        self.setNavigationAssetsStyle(self.navigationController)
        
        //text area border
        contentField.layer.borderColor = UIAssets.logoColor.greyColor.CGColor
        contentField.layer.cornerRadius = 5
        contentField.layer.borderWidth = 1
        contentField.layer.masksToBounds = true
        
        postButton.layer.cornerRadius = 5
        postButton.layer.masksToBounds = true
        
        
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
    
    func postPressed(sender:UIButton!)
    {
        if !contentField.text.isEmpty && titleLabel.text != nil
        {
            coreLocation.loadCurrentLocation({
                location in
                
                dispatch_async(dispatch_get_main_queue(),
                    {
                        let message = Message()
                        message.user = User.getCurrentUserId()
                        message.content = self.contentField.text!
                        message.setPosition(location.coordinate.latitude, longitudeInput: location.coordinate.longitude)
                        message.saveInBackground()
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                })
            })

            
        }
    }


}
