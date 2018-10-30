//
//  RouteParameter.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 06/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import CoreLocation

class RouteParameter: NSObject {
    var startCoordinate: CLLocationCoordinate2D
    var endCoordinate: CLLocationCoordinate2D
    
    init(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D)
    {
         self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
    }
}
