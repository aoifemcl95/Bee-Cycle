//
//  MapViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 31/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate : class
{
    func mapViewDidSelectSearch(mapView: MKMapView?)
    
}


class MapViewController: UIViewController, MKMapViewDelegate, LocationServiceDelegate, Storyboarded{
    let regionRadius: CLLocationDistance = 1000
    var cycleService = CycleService()
    var cycleStreetService = CycleStreetService()
    var annotations = NSMutableArray()
    var locationService = LocationService()
    var hasGotRegion = false
    weak var mapItem = MKMapItem()
    var cycleLockerArray = [CycleLocker]()
    weak var coordinator: MainCoordinator?
    var routeDirections = ""
    var locationSearchTableViewController = LocationSearchTable()
//    var bottomSheetViewController = BottomSheetViewController.init(nibName: "BottomSheetViewController", bundle: nil)
    weak var delegate: MapViewControllerDelegate?
    var journeyOrigin = MKMapItem()
    var journeyDest = MKMapItem()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locateMe: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationService.delegate = self
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        self.locationSearchTableViewController.delegate = self
        print(self.locationService.userLocation!.coordinate)

        
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        createLocationTable()
//        delegate?.mapViewDidSelectSearch(mapView: self.mapView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func locateMeTapped(_ sender: Any) {
        zoomToUserLocation()
        createAnnotations()
    }
    
    func createMapPin(mapItem: MKMapItem)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapItem.placemark.coordinate.latitude, longitude: mapItem.placemark.coordinate.longitude)
        annotation.title = mapItem.placemark.name
        mapView.addAnnotation(annotation as MKAnnotation)
    }
    
    
    func createAnnotations() {
        annotations = []
        for cycleLocker in cycleLockerArray {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: cycleLocker.latitude, longitude: cycleLocker.longitude)
            annotation.title = cycleLocker.locationType
            annotation.subtitle = cycleLocker.type
            annotations.add(annotation)
            mapView.addAnnotations(annotations as! [MKAnnotation])
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didUpdateLocation() {
        if !hasGotRegion{
            zoomToUserLocation()
            if ((mapItem) != nil)
            {
                self.createMapPin(mapItem: mapItem!)
                self.centerMapOnLocation(location: (mapItem?.placemark.location)!)
//                self.addBottomSheetView()
            }
            hasGotRegion = true
        }
    }
    
    func createPolyline()
    {
        let coordinatesArray = cycleStreetService.coordinateArray
        let polyline = MKPolyline(coordinates: coordinatesArray, count: coordinatesArray.count)
        mapView.add(polyline, level: MKOverlayLevel.aboveRoads)
    }
    
    
    func zoomToUserLocation () {
        let center = CLLocationCoordinate2D(latitude: (self.locationService.userLocation?.coordinate.latitude)!, longitude: (self.locationService.userLocation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.1, 0.1))
        
        mapView.setRegion(region, animated: true)
        
        cycleService.requestCycleLocker { (cycleLockerArray) in
            DispatchQueue.main.async {
                self.cycleLockerArray = cycleLockerArray
                self.createAnnotations()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let pinIdent = "Pin"
            var pinView: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                
            }
            pinView.canShowCallout = true;
            pinView.image = UIImage(named: "CycleLocker")
            pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return pinView;
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.yellow
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        routeDirections.removeAll()
//        hideBottomSheetView()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation {
                self.directionInCurrentMap(to: annotation.coordinate)
                self.durationForJourney(to: annotation.coordinate)
            }
        }
    }
    
    func createBottomSheet(journeyPlannerResult: JourneyPlannerResult, mapItem: MKMapItem){
        let bottomSheetViewController = BottomSheetViewController(journeyPlannerResult: journeyPlannerResult, mapItem: mapItem)
        self.addChildViewController(bottomSheetViewController)
        self.view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.didMove(toParentViewController: self)
        
        let height = view.frame.height
        let width = view.frame.width
        bottomSheetViewController.view.frame = CGRect(x: 0, y: self.view.frame.maxX, width: width, height: height)
    }
    
    
    // cycle locker methods - bottom view controller
    
    func addBottomSheetView(mapItem: MKMapItem) {
        
        if (mapItem != nil && self.locationService.userLocation != nil)
        {
            let locationString = createStringFromCoordinate(coordinate: (self.locationService.userLocation?.coordinate)!)
            let destinationCoordString = createStringFromCoordinate(coordinate: mapItem.placemark.coordinate)
            let coordinateString = "\(locationString)|\(destinationCoordString)"
            let urlCoordinateString = coordinateString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            cycleStreetService.requestCycleStreet(coordinates: urlCoordinateString!) { (journeyPlannerResult: JourneyPlannerResult) in
                self.createPolyline()
                self.createBottomSheet(journeyPlannerResult: journeyPlannerResult, mapItem: mapItem)
                
            }
        }
        
    }
    
//    func hideBottomSheetView() {
//        bottomSheetViewController.view.frame = CGRect(x: 0, y: self.view.frame.maxX, width: view.frame.width, height: 0)
//    }
    
    func directionInCurrentMap(to destination: CLLocationCoordinate2D)
    {
        let request = MKDirectionsRequest()
        let placemark = MKPlacemark(coordinate: destination)
        let cycleLockerMapItem = MKMapItem(placemark: placemark)
        request.source = MKMapItem.forCurrentLocation()
        request.destination = cycleLockerMapItem
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response!)
            }
        }
        
    }
    
    func showRoute(_ response: MKDirectionsResponse)
    {
        for route in response.routes {
            var overlayArray = self.mapView.overlays
            mapView.removeOverlays(overlayArray)
            mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            overlayArray.append(route.polyline)
            for step in route.steps
            {
                routeDirections.append(step.instructions)
                routeDirections.append("\n")
                
            }
//            bottomSheetViewController.updateDirectionsForLabel(routeDirections: routeDirections)
            
        }
    }
    
    func durationForJourney(to destination: CLLocationCoordinate2D)
    {
        let request = MKDirectionsRequest()
        let placemark = MKPlacemark(coordinate: destination)
        let cycleLockerMapItem = MKMapItem(placemark: placemark)
        request.source = MKMapItem.forCurrentLocation()
        request.destination = cycleLockerMapItem
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculateETA { (response, error) in
            if error != nil {
                print("ERROR WHEN GETTING DURATIONS")
            }
            else {
                let seconds = response?.expectedTravelTime
                let minutesInteger = Int(seconds!/60)
                let minutes = String("Duration: \(minutesInteger)mins")
//                self.bottomSheetViewController.showDurationOfRoute(timeInMinutes: minutes)
            }
        }
    }
    
    func createStringFromCoordinate(coordinate: CLLocationCoordinate2D) -> String
    {
        let latString = String(format: "%f", coordinate.latitude)
        let lngString = String(format: "%f", coordinate.longitude)
        return "\(lngString),\(latString)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func createLocationTable(){
        self.addChildViewController(locationSearchTableViewController)
        self.view.addSubview(locationSearchTableViewController.view)
        locationSearchTableViewController.didMove(toParentViewController: self)
        
        let height = view.bounds.maxY
        let width = view.frame.width
        locationSearchTableViewController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        locationTableViewController.view.frame = CGRect(x: 0, y: self.view.frame.maxX, width: width, height: height)
    }
    
    
}

extension MapViewController : LocationSearchDelegate
{
    func didSelectResult(mapItem: MKMapItem) {
        locationSearchTableViewController.view.frame = CGRect(x: 0, y: self.view.frame.maxX, width: view.frame.width, height: 0)
            self.createMapPin(mapItem: mapItem)
            self.centerMapOnLocation(location: (mapItem.placemark.location)!)
            self.addBottomSheetView(mapItem: mapItem)
    }
    
}


