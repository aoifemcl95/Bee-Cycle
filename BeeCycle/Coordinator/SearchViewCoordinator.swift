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
    private var searchViewController: SearchViewController?
    private var searchViewCoordinator: SearchViewCoordinator?
    private var routePlanCoordinator : RoutePlanCoordinator?

    
    
    init(presenter: UINavigationController)
    {
        self.presenter = presenter
    }
    
    func start() {
        let searchViewController = SearchViewController(fromTapped: true, toTapped: false)
        presenter.pushViewController(searchViewController, animated: true)
        self.searchViewController = searchViewController
        self.searchViewController?.locationSearchTable.delegate = self
    }
}

extension SearchViewCoordinator : LocationSearchDelegate
{
    func didSelectResult(mapItem: MKMapItem) {
        let routePlanCoordinator = RoutePlanCoordinator(presenter :presenter, mapItem:mapItem)
        routePlanCoordinator.start()
        self.routePlanCoordinator = routePlanCoordinator
    }
}
