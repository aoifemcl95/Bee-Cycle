//
//  LocationProtocol.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class LocationProtocol: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var searchName: String?
    var searchDetail: String?
    
    
    init(coordinate: CLLocationCoordinate2D, searchName: String?, searchDetail: String?)
    {
        self.coordinate = coordinate
        self.searchDetail = searchDetail
        self.searchName = searchName
    }
    
}


