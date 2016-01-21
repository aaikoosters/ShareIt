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
    @IBOutlet weak  var sliderRange : UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segment .addTarget(self, action: "segmentSwitched:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.sliderRange .addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        
        
        
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
        
        if let currentRange = defaults.valueForKey(UserDefaultsKeys.UserDefaultsKey.rangeRegion) as? Int
        {
            self.sliderRange.value = Float(currentRange)
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

    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewcontrollers = self.navigationController?.viewControllers
        {
            for controller in viewcontrollers
            {
                if let home = controller as? HomeViewController
                {
                    home.loadLocation()
                    home.reloadPins()
                }
            }
        }

    }
    
    func sliderValueChanged(sender: UISlider)
    {
        let currentValue = Int(sender.value)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(currentValue, forKey:  UserDefaultsKeys.UserDefaultsKey.rangeRegion)
        defaults.synchronize()
    }
    
}