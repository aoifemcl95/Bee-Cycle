//
//  JourneyPlannerResult.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class JourneyPlannerResult: NSObject {
    var polylineCoordinates: [CLLocationCoordinate2D]
    
    init(polylineCoordinates: [CLLocationCoordinate2D])
    {
        self.polylineCoordinates = polylineCoordinates
    }
}
