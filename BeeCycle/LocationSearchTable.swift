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
    
    @IBOutlet weak var tableView: UITableView!
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? =  nil
    var endCoordinate: CLLocationCoordinate2D? = nil
    var startCoordinate: CLLocationCoordinate2D? = nil
    var coordinator: MainCoordinator?
    let navController = UINavigationController()
    var delegate: LocationSearchDelegate?
    var isSearching: Bool = false
    var searchText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LocationSearchTable.handleTextChange(_:)),
                                               name: NSNotification.Name(rawValue: handleTextChangeNotification), object: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "LocationSearchResultCell", bundle: nil), forCellReuseIdentifier: "cell")
        definesPresentationContext = true
        self.tableView.backgroundColor = UIColor.clear
        self.prepareBackgroundView()
   
    }
    
    @objc func handleTextChange(_ myNot: Notification) {
        if let use = myNot.userInfo {
            if let text = use["text"] {
                searchText = text as! String
            }
        }
        updateSearchResults()
        tableView.reloadData()
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
    
    func prepareBackgroundView()
    {
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = self.tableView.frame
        bluredView.frame = self.tableView.frame
        
        self.tableView.backgroundView = bluredView
        
//        self.tableView.insertSubview(bluredView, at: 0)
    }
    
    func updateSearchResults() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}









