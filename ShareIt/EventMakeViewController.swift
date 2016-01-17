//
//  EventMakeViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import Parse

class EventMakeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var geoLocation: UITextField!
    @IBOutlet weak var geoLocationTwo: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDate: UITextField!
    
    var zichtbaar = "Private"
    let event = Event()
    
    @IBOutlet weak var segmendPicker: UISegmentedControl!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func segmendChanged(sender: UISegmentedControl) {

        switch segmendPicker.selectedSegmentIndex
        {
        case 0:
            zichtbaar = "Private"
        case 1:
            zichtbaar = "Public"
        default:
            break; 
        }
        
    }
    
    @IBAction func pickerStart(sender: AnyObject) {
        datePickerStart(sender as! UIDatePicker)
    }
    
    @IBAction func pickerEnd(sender: AnyObject) {
        datePickerEInd(sender as! UIDatePicker)
    }
    @IBAction func saveEvent(sender: AnyObject) {
              
        event.startDate = startDate.text!
        event.endDate = endDate.text!
        event.eventName = nameEvent.text!
        event.viewAble = zichtbaar
//        event.position
//        event.content = content.text!
        
        print("zichttbaar", event.viewAble)
        event.saveInBackground()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func datePickerStart(datePicker:UIDatePicker) {
        let dati = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let strDate = dateFormatter.stringFromDate(dati)

        startDate.text = strDate

    }
    
    func datePickerEInd(datePicker: UIDatePicker) {
        let dati = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let strDate = dateFormatter.stringFromDate(dati)
        
        endDate.text = strDate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameEvent.delegate = self
        
//        // Do any additional setup after loading the view.
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
