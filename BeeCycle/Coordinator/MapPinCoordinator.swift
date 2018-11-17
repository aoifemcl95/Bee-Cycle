//
//  MapPinCoordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 17/11/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class MapPinCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let mapItem: MKMapItem
    private var mapViewController : MapViewController?
    private var searchViewCoordinator : SearchViewCoordinator?
    
    init(presenter: UINavigationController, mapItem: MKMapItem)
    {
        self.presenter = presenter
        self.mapItem = mapItem
    }
    
    func start() {
        let mapViewController = MapViewController()
        mapViewController.mapItem = self.mapItem
        presenter.pushViewController(mapViewController, animated: true)
        self.mapViewController = mapViewController
    }
}

