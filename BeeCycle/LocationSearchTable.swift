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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? =  nil
    var endCoordinate: CLLocationCoordinate2D? = nil
    var startCoordinate: CLLocationCoordinate2D? = nil
    var coordinator: MainCoordinator?
    let navController = UINavigationController()
    var delegate: LocationSearchDelegate?
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UINib(nibName: "LocationSearchResultCell", bundle: nil), forCellReuseIdentifier: "cell")
        definesPresentationContext = true
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
        if (isSearching)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LocationSearchResultCell
            let resultAtIndex = matchingItems[indexPath.row].placemark
            cell.searchResultLabel?.text = resultAtIndex.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let mapItem = matchingItems[indexPath.row]
            delegate?.didSelectResult(mapItem: mapItem)
        
   
    }
    
}

extension LocationSearchTable : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
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
        isSearching = true
    }

}








