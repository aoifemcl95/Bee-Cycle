//
//  SearchViewCoordinatorTwo.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 06/11/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class SearchViewCoordinatorTwo: Coordinator {
    
    private let presenter: UINavigationController
    private var locationSearchTable: LocationSearchTable?
    private var searchViewCoordinatorTwo : SearchViewCoordinatorTwo?
    private var routePlanCoordinator: RoutePlanCoordinator?
    
    init(presenter: UINavigationController)
    {
        self.presenter = presenter
    }
    
    func start() {
        let locationSearchTable = LocationSearchTable()
        presenter.popViewController(animated: false)
//        presenter.popToViewController(LocationSearchTable, animated: true)
        self.locationSearchTable = locationSearchTable
        self.locationSearchTable?.delegate = self
    }
    
    
}
extension SearchViewCoordinatorTwo : LocationSearchDelegate
{
    func didSelectResult(mapItem: MKMapItem) {
        let routePlanCoordinator = RoutePlanCoordinator(presenter :presenter, mapItem:mapItem)
        routePlanCoordinator.start()
        self.routePlanCoordinator = routePlanCoordinator
    }
}

