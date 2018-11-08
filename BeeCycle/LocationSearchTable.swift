//
//  LocationSearchTable.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 23/08/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

protocol LocationSearchDelegate: class
{
    func didSelectResult(mapItem: MKMapItem)
}

class LocationSearchTable: UIViewController, UITableViewDelegate, UITableViewDataSource{
//    var fromTapped: Bool
//    var toTapped: Bool
    
    @IBOutlet weak var tableView: UITableView!
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? =  nil
    var endCoordinate: CLLocationCoordinate2D? = nil
    var startCoordinate: CLLocationCoordinate2D? = nil
    var coordinator: MainCoordinator?
    let navController = UINavigationController()
    var delegate: LocationSearchDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        coordinator = MainCoordinator(navigationController: navController)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "LocationSearchResultCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Where are you going?"
        navigationItem.titleView = searchController.searchBar
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 414, height: 44)
        searchController.hidesNavigationBarDuringPresentation = false
        

//        navigationItem.searchController = searchController
        definesPresentationContext = true


    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.isActive = true
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.removeFromSuperview()
    }
    init()
    {
         super.init(nibName: nil, bundle: nil)
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
            let mapItem = matchingItems[indexPath.row]
            delegate?.didSelectResult(mapItem: mapItem)
        searchController.searchBar.text = nil
   
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

extension LocationSearchTable : UISearchControllerDelegate
{
    func didPresentSearchController(_ searchController: UISearchController) {
        print("YESS IT'S BEEN CALLED")
    }
}







