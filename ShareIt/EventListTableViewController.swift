//
//  EventListTableViewController.swift
//  ShareIt
//
//  Created by Aaik Oosters on 06-01-16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit

struct Evenemten {
    let title: String
    let date: String
    let beschrijving: String
}

class EventListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var evenemt = [
        Evenemten(title: "Event 1", date: "10-01-2016", beschrijving: "beschrijving bij event 1"),
        Evenemten(title: "Event 2", date: "10-01-2016", beschrijving: "beschrijving bij event 1"),
        Evenemten(title: "Event 3", date: "10-01-2016", beschrijving: "beschrijving bij event 1")
        
    ]
    
    var searchText = "a"
    var eventList = Event()
    var eventLoader = ContentLoaderEvent()
    
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
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        eventLoader.loadAllEvents({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
        
        //navigation bar color
        self.navigationController?.navigationBar.barTintColor = UIAssets.logoColor.redColor
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //title font color and size
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("CELL")!
            let event = eventLoader.events[indexPath.row]
            cell.textLabel?.text = event.eventName
//            cell.detailTextLabel?.text = evenemt[indexPath.row].date
            return cell
    }

}
