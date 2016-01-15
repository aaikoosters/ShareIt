//
//  MapViewViewController.swift
//  ShareIt
//
//  Created by Daniello on 06/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView : MKMapView!{
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.showsUserLocation = true

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationAssetsStyle(self.navigationController)

    }

}
