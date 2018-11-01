//
//  RoutePlanCoordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 31/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class RoutePlanCoordinator: Coordinator {

    private let presenter: UINavigationController
    private var routePlanViewController : RoutePlanViewController?
    private var routePlanCoordinator : RoutePlanCoordinator?
    private var searchViewCoordinator: SearchViewCoordinator?
    private let mapItem: MKMapItem
    
    
    init(presenter: UINavigationController, mapItem: MKMapItem)
    {
        self.presenter = presenter
        self.mapItem = mapItem
        
    }
    
    func start()
    {
        let routePlanViewController = RoutePlanViewController()
        routePlanViewController.mapItem = mapItem
        presenter.pushViewController(routePlanViewController, animated: true)
        
        self.routePlanViewController = routePlanViewController
        routePlanViewController.delegate = self
    }
}

extension RoutePlanCoordinator : RoutePlanDidSelectSearchDelegate
{
    func routePlanDidSelectSearch() {
        let searchViewCoordinator = SearchViewCoordinator(presenter :presenter)
        searchViewCoordinator.start()
        self.searchViewCoordinator = searchViewCoordinator
    }
}



