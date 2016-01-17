//
//  HomeSettingViewcontroller.swift
//  ShareIt
//
//  Created by Daniello on 17/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import UIKit

class HomeSettingViewcontroller: UITableViewController
{
    
    @IBOutlet weak  var segment : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segment .addTarget(self, action: "segmentSwitched:", forControlEvents: UIControlEvents.ValueChanged)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let selected = defaults.valueForKey(UserDefaultsKeys.UserDefaultsKey.mapType) as? Bool
        {
            if selected
            {
                self.segment.selectedSegmentIndex = 0
            }
            else
            {
                self.segment.selectedSegmentIndex = 1
            }
        }


    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func segmentSwitched(sender:UISegmentedControl)
    {
        switch segment.selectedSegmentIndex
        {
        case 0:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey:  UserDefaultsKeys.UserDefaultsKey.mapType)
            defaults.synchronize()
            
        case 1:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(false, forKey: UserDefaultsKeys.UserDefaultsKey.mapType)
        default:
            break; 
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "Home"
        {
            if let homeView = segue.destinationViewController as? HomeViewController
            {
                
            }
        }
        
        
    }

}
