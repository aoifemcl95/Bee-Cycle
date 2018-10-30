//
//  MainCoordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 30/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displaySearch(fromTapped: Bool, toTapped: Bool)
    {
        let vc = SearchViewController(fromTapped: fromTapped, toTapped: toTapped)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayRoutePlan(journeySelection: JourneySelection)
    {
        let vc = RoutePlanViewController(journeySelection: journeySelection)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
