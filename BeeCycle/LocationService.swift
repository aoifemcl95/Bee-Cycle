//
//  LocationService.swift
//  Induction Task
//
//  Created by Aoife McLaughlin on 28/09/2017.
//  Copyright © 2017 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol LocationServiceDelegate: class {
    func didUpdateLocation()
}

class LocationService: NSObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    var userLocation: CLLocation?
    
    weak var delegate: LocationServiceDelegate?
    
    override init()
    {
        super.init()
        
        self.locationManager = CLLocationManager()
        self.userLocation = CLLocation()
    
        if CLLocationManager.authorizationStatus() == .notDetermined {
            
            self.locationManager?.requestAlwaysAuthorization()
        }
    

    
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.distanceFilter = 200
        self.locationManager?.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
        
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
        
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        userLocation = locations[0] as CLLocation
        delegate?.didUpdateLocation()        
    }


}
