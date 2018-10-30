//
//  CycleLocker.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 10/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit


class CycleLocker: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var imageName = "CycleLocker"
    let location: [String: Any]
    let type: String
    let locationType: String
    let latitude: Double
    let longitude: Double
    
    
    init(location: [String: Any], type: String, locationType: String, latitude: Double, longitude: Double, coordinate: CLLocationCoordinate2D)
    {
        self.location = location
        self.type = type
        self.locationType = locationType
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = coordinate
    }


}
