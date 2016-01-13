//
//  EventMakeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class EventMakeViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var geoLocation: UITextField!
    @IBOutlet weak var geoLocationTwo: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDate: UITextField!
    
    let event = Event()
    
    @IBAction func saveEvent(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyy-mm-dd"
        let startdate = dateFormatter.dateFromString(startDate.text!)!
        let enddate = dateFormatter.dateFromString(endDate.text!)!
        
        event.startDate = startdate
        event.endDate = enddate
        event.eventName = nameEvent.text!
//        event.position
        event.content = content.text!
        

        event.saveInBackground()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeTab") as UIViewController
            
            viewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(viewController, animated: true, completion: nil)
        })

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
