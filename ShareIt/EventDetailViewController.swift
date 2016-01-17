//
//  EventSeeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var titel: String = "" {
        didSet {
//            updateUI()
            print("dit is de titel ", titel )
        }
    }
    var beginDatum: String = "" {
        didSet {
//            updateUI()
        }
    }
    var eindDatum: String = "" {
        didSet {
//            updateUI()
        }
    }
    var locatie: String = "" {
        didSet {
//            updateUI()
        }
    }
    
    var detail: String = "" {
        didSet {
//            updateUI()
        }
    }
    
    var image: String = "" {
        didSet {
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
