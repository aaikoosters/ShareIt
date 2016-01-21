//
//  EventMakeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse
import MapKit

class EventMakeViewController: UIViewController, MKMapViewDelegate
{

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var accessLevel: UISegmentedControl!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.showsUserLocation = true
            
        }
    }
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    let dateFormatter = NSDateFormatter()
    let coreLocation = CoreLocation()
    
    @IBAction func saveEvent(sender: AnyObject)
    {
        
        if nameEvent.text != nil
        {
            if !nameEvent.text!.isEmpty
            {
                if !content.text.isEmpty
                {
                    coreLocation.loadCurrentLocation({
                        location in
                        
                        dispatch_async(dispatch_get_main_queue(),
                            {
                                let event = Event()
                                event.startDate = self.startDate.text!
                                event.endDate = self.endDate.text!
                                event.eventName = self.nameEvent.text!
                                
                                let segmentIndex = self.accessLevel.selectedSegmentIndex
                                event.viewAble = self.accessLevel.titleForSegmentAtIndex(segmentIndex)!
                                event.user = User.getCurrentUserId()
                                
                                event.setPosition(location.coordinate.latitude, longitudeInput: location.coordinate.longitude)
                                event.content = self.content.text!
                                
                                self.activityIndicator.startAnimating()
                                self.activityIndicator.hidden = false
                                
                                event.saveInBackgroundWithBlock({ (isComplete, error) -> Void in
                                    
                                    self.activityIndicator.stopAnimating()
                                    self.activityIndicator.hidden = true
                                    
                                    let alert = UIAlertView(title: "Event", message: "Event created", delegate: self, cancelButtonTitle: "OK")
                                    alert.tag = 11
                                    alert.show()
                                })
                        })
                    })

                    
                }
                else
                {
                    let alert = UIAlertView(title: "Description", message: "Description cannot be empty", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            }
            else
            {
                let alert = UIAlertView(title: "Event Name", message: "Event Name cannot be empty", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        }
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
        {
        case 0:
            if View.tag == 11
            {
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        default: break
        }
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
    
    @IBAction func startDateChanged(sender: UIDatePicker)
    {
        startDate.text = dateFormatter.stringFromDate(startDatePicker.date)
    }

    @IBAction func endDateChanged(sender: UIDatePicker)
    {
        endDate.text = dateFormatter.stringFromDate(endDatePicker.date)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        startDate.text = dateFormatter.stringFromDate(startDatePicker.date)
        endDate.text = dateFormatter.stringFromDate(endDatePicker.date)
        
        content.layer.borderColor = UIAssets.logoColor.greyColor.CGColor
        content.layer.cornerRadius = 5
        content.layer.borderWidth = 1
        content.layer.masksToBounds = true
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

}
