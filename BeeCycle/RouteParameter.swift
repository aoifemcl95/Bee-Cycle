//
//  RouteParameter.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 06/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RouteParameter: NSObject {
    var destination: MKMapItem
    
    init(destination: MKMapItem)
    {
        self.destination = destination
    }
}
