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
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.eventLoader.events.removeAll()
        self.tableView.reloadData()
        
        eventLoader.loadAllEvents({
            users in
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        })
        
        self.setNavigationAssetsStyle(self.navigationController)
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventSearchCell")!  as! EventSearchViewCell
        let event = self.eventLoader.events[indexPath.row]
        
        cell.eventName.text = event.eventName
        cell.eventDisplay.image = UIImage(named: "logo200")
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return eventLoader.events.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForSelectedRow!
//        self.titleOefening = self.oef[indexPath.row].title
//        self.oefUitleg = self.oef[indexPath.row].spierUit
//        self.spierGroep = self.oef[indexPath.row].spierGroep
//        self.link = self.oef[indexPath.row].youtubeLink
        
        print("in de swqu")
        
        let currentCell = self.tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        let aaik = (currentCell.textLabel!.text)!
        print("selectedIndex bitttaas, ", aaik)
        
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let odv = destination as? EventDetailViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "eventDetail":
//                    odv.uitlegOefening = oefUitleg
//                    odv.titelOefening = titleOefening
//                    odv.spierGroep = spierGroep
//                    odv.YoutubeURL = link
                    odv.titel = "Aaikie"
                default: break
                }
            }
        }
    }
    

}
