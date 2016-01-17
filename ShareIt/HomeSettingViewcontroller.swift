//
//  HomeSettingViewcontroller.swift
//  ShareIt
//
//  Created by Daniello on 17/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import UIKit

class HomeSettingViewcontroller: UIViewController
{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let locateButton = UIButton()
        locateButton.setImage( UIImage(named:"location"), forState: .Normal)
        locateButton.frame.size = CGSize(width: 40.0, height: 40.0)
        
        
        locateButton.center = self.view .convertPoint(self.view.center, fromView: self.view)
        
        self.view.addSubview(locateButton)
        
    }
}
