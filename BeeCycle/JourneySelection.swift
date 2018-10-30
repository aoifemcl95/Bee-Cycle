//
//  JourneySelection.swift
//  
//
//  Created by Aoife McLaughlin on 30/10/2018.
//

import UIKit
import MapKit

class JourneySelection: NSObject {

    var origin: MKMapItem?
    var destination: MKMapItem?
    
    
    init(origin: MKMapItem?)
    {
        self.origin = origin!
        
    }
    
    init(destination: MKMapItem?)
    {
        self.destination = destination!
    }
    
}
