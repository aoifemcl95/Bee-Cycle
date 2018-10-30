//
//  LocationSearchTable.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 23/08/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var fromTapped: Bool
    var toTapped: Bool
    
    @IBOutlet weak var tableView: UITableView!
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? =  nil
    var endCoordinate: CLLocationCoordinate2D? = nil
    var startCoordinate: CLLocationCoordinate2D? = nil
    var coordinator: MainCoordinator?
    let navController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = MainCoordinator(navigationController: navController)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "LocationSearchResultCell", bundle: nil), forCellReuseIdentifier: "cell")

    }
    
    init(fromTapped: Bool, toTapped: Bool) {
        self.fromTapped = fromTapped
        self.toTapped = toTapped
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = LocationSearchResultCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LocationSearchResultCell
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.searchResultLabel?.text = selectedItem.name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fromTapped
        {
            let journeySelection = JourneySelection(origin: matchingItems[indexPath.row])
            self.coordinator?.displayRoutePlan(journeySelection: journeySelection)
        }
        else if toTapped
        {
            let journeySelection = JourneySelection(destination: matchingItems[indexPath.row])
            self.coordinator?.displayRoutePlan(journeySelection: journeySelection)
        }
    }
    

}
    
extension LocationSearchTable : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}



