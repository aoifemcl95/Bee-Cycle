//
//  RoutingParameter.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class RoutingParameter: NSObject {
    var searchName: String
    var searchDetail : String
    var coordinate: CLLocationCoordinate2D
    
    
    init(searchName: String, searchDetail: String, coordinate: CLLocationCoordinate2D) {
        self.searchName = searchName
        self.searchDetail = searchDetail
        self.coordinate = coordinate
    }
}
