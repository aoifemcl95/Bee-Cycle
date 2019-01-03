//
//  SearchViewCoordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 31/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class SearchViewCoordinator: Coordinator {

    private let presenter: UINavigationController
    private var locationSearchTable: LocationSearchTable?
    private var searchViewCoordinator: SearchViewCoordinator?
    var mapView: MKMapView?
    var mapPinCoordinator : MapPinCoordinator?

    
    
    init(presenter: UINavigationController)
    {
        self.presenter = presenter
    }
    
    func start() {
        let locationSearchTable = LocationSearchTable()
        locationSearchTable.mapView = mapView
        presenter.pushViewController(locationSearchTable, animated: true)
        self.locationSearchTable = locationSearchTable
        self.locationSearchTable?.delegate = self
    }
}

extension SearchViewCoordinator : LocationSearchDelegate
{
    func didSelectResult(mapItem: MKMapItem) {
        let mapPinCoordinator = MapPinCoordinator(presenter:presenter, mapItem:mapItem)
        mapPinCoordinator.start()
        self.mapPinCoordinator = mapPinCoordinator
    }
}
