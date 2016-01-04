//
//  MainLogoViewController.swift
//  ShareIt
//
//  Created by Daniello on 04/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class MainLogoViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        super.viewWillDisappear(animated)
    }

    
}
