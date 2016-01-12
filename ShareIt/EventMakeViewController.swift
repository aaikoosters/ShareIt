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
        dateFormatter.dateFormat = "yyyy-mm-dd"
//        let date = dateFormatter.dateFromString(startDate.text!)
        
        event.startDate = dateFormatter.dateFromString(startDate.text!)!
        event.endDate = dateFormatter.dateFromString(endDate.text!)!
//        event.position
        event.content = content.text!
        event.saveInBackground()
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
