//
//  RoutePlanViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit


class RoutePlanViewController: UIViewController, UISearchBarDelegate, LocationServiceDelegate {
   
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromButton: UIButton!
    
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toView: UIView!
//    var fromRoutingParameter: MKMapItem
//    var toRoutingParamter: MKMapItem
    var journeySelection: JourneySelection
    var locationSearchTable = LocationSearchTable(fromTapped: false, toTapped: false)
    var resultSearchController: UISearchController? = nil
    var viewController = ViewController()
    var fromTapped: Bool = false
    var toTapped: Bool = false
    var locationService = LocationService()
    var hasGotRegion = false
    var navController = UINavigationController()
    var coordinator: MainCoordinator?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = MainCoordinator(navigationController: navController)
        if journeySelection.origin != nil
        {
            self.fromLabel.text = journeySelection.origin?.placemark.name
        }
        else if journeySelection.destination != nil
        {
            self.toLabel.text = journeySelection.destination?.placemark.name
        }
        
        locationService.delegate = self
        setupSearchBar()
//        self.routeNavController = UINavigationController(rootViewController: self)
        // Do any additional setup after loading the view.
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(journeySelection: JourneySelection)
    {
        self.journeySelection = journeySelection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.present(resultSearchController!, animated: true, completion: nil)
    }
    
    
    func setupSearchBar()
    {
        let locationSearchTable = LocationSearchTable(fromTapped: self.fromTapped, toTapped: self.toTapped)
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Where are you going to?"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    @IBAction func fromTapped(_ sender: Any) {
        self.fromTapped = true
        self.toTapped = false
        self.coordinator?.displaySearch(fromTapped: self.fromTapped, toTapped: self.toTapped)
        
        
    }
    
    @IBAction func toTapped(_ sender: Any) {
        self.toTapped = true
        self.fromTapped = false
        self.coordinator?.displaySearch(fromTapped: self.fromTapped, toTapped: self.toTapped)
    }
    
    func didUpdateLocation() {
        if !hasGotRegion{
            hasGotRegion = true
        }
    }
    
}
