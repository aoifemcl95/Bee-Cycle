//
//  SearchViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 01/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, LocationServiceDelegate {

    var resultSearchController: UISearchController? = nil
    var mapView: MKMapView? =  nil
    var locationService = LocationService()
    var hasGotRegion = false
    var fromTapped: Bool = false
    var toTapped: Bool = false
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.delegate = self
        setupSearchBar()

        // Do any additional setup after loading the view.
    }
    
    init(fromTapped: Bool, toTapped: Bool)
    {
        self.fromTapped = fromTapped
        self.toTapped = toTapped
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSearchBar()
    {
        let locationSearchTable = LocationSearchTable(fromTapped: self.fromTapped, toTapped: self.toTapped)
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Where are you coming from?"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
    }
    
    func didUpdateLocation() {
        if !hasGotRegion{
            hasGotRegion = true
        }
    }


}
