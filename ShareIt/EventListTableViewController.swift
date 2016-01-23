//
//  EventListTableViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

//struct Evenemten {
//    let title: String
//    let date: String
//    let beschrijving: String
//}

class EventListTableViewController: UITableViewController, UISearchBarDelegate {
    
//    var evenemt = [
//        Evenemten(title: "Event 1", date: "10-01-2016", beschrijving: "beschrijving bij event 1"),
//        Evenemten(title: "Event 2", date: "10-01-2016", beschrijving: "beschrijving bij event 1"),
//        Evenemten(title: "Event 3", date: "10-01-2016", beschrijving: "beschrijving bij event 1")
//        
//    ]
    
    var searchText = "a"
    var eventList = Event()
    var eventLoader = ContentLoaderEvent()
    let coreLocation = CoreLocation()
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        eventLoader.searchEvent(searchText) { (returnMessages) -> Void in
            self.tableView.reloadData() }
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setRefreshControl()
        startRefresh()
    }
    
    func startRefresh()
    {
        if self.refreshControl != nil
        {
            self.refreshControl?.beginRefreshing()
            self.refresh(self.refreshControl!)
        }
    }
    
    func refresh(sender:AnyObject)
    {
        self.eventLoader.events.removeAll()
        self.tableView.reloadData()
        
        
        if let currentRange =  NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultsKeys.UserDefaultsKey.rangeRegion) as? Int
        {
            eventLoader.loadAllEventsinRangeFriends(coreLocation.currentLocation.coordinate.latitude, userlongitude: coreLocation.currentLocation.coordinate.longitude, range: currentRange, completion :{ (returnMessages) -> Void in
               
                dispatch_async(dispatch_get_main_queue(),
                    {
                        self.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                })
            })
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventSearchCell")!  as! EventSearchViewCell
        
        if self.eventLoader.events.count > 0
        {
            let event = self.eventLoader.events[indexPath.row]
            
            cell.eventName.text = event.eventName
            cell.eventDisplay.image = UIImage(named: "logo200")
            eventLoader.loadPhotoForEvent(event.eventPicture, completion: { (image) -> Void in
                cell.eventDisplay.image = UIImage(data:image!)
            })
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return eventLoader.events.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier
        {
            switch identifier
            {
                case "showEventDetail":
                let selectedEvent = self.eventLoader.events[self.tableView.indexPathForSelectedRow!.row]
                let destination = segue.destinationViewController as! EventDetailViewController
                destination.receivedEvent = selectedEvent
                
            default: break
            }
        }
    }

}
