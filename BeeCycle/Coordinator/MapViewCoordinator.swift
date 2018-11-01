//
//  MapViewCoordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 31/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

class MapViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var mapViewController : MapViewController?
    private var searchViewCoordinator : SearchViewCoordinator?

    
    init(presenter: UINavigationController)
    {
         self.presenter = presenter
    }
    
    func start()
    {
        let mapViewController = MapViewController(nibName: nil, bundle: nil)
        mapViewController.title = "Map view"
        presenter.pushViewController(mapViewController, animated: true)
        
        self.mapViewController = mapViewController
        mapViewController.delegate = self
    }
}

extension MapViewCoordinator : MapViewControllerDelegate
{
    func mapViewDidSelectSearch() {
        let searchViewCoordinator = SearchViewCoordinator(presenter :presenter)
        searchViewCoordinator.start()
        self.searchViewCoordinator = searchViewCoordinator
    }
}
