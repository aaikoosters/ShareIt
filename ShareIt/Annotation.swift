//
//  Anotation.swift
//  ShareIt
//
//  Created by Daniello on 11/01/16.
//  Copyright © 2016 Aaik Oosters. All rights reserved.
//


import Foundation
import MapKit

extension Message : MKAnnotation
{
    var coordinate : CLLocationCoordinate2D
        {
            return CLLocationCoordinate2D(latitude: position.latitude , longitude: position.longitude)
    }
    
    var title : String?
        {
            return postTitle
    }
    
    var subtitle : String?
        {
            return content
    }
    
     var color: MKPinAnnotationColor
        {
        return  MKPinAnnotationColor.Green
    }
    
}


extension Event : MKAnnotation
{
    var coordinate : CLLocationCoordinate2D
        {
            return CLLocationCoordinate2D(latitude: position.latitude , longitude: position.longitude)
    }
    var title : String?
        {
            return eventName
    }
    
    var subtitle : String?
        {
            return content
    }
}