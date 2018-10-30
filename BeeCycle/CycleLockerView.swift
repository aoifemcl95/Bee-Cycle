//
//  CycleLockerView.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class CycleLockerView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let cycleLocker = newValue as? CycleLocker else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let imageName = cycleLocker.imageName
            image = UIImage(named: imageName)
        }
    }
}
