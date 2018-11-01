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
    var rootViewController: UINavigationController
    let mapViewCoordinator: MapViewCoordinator
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
        rootViewController = UINavigationController()
        
        //5
        mapViewCoordinator = MapViewCoordinator(presenter: rootViewController)
    }
    
    func start()
    {
        window.rootViewController = rootViewController
        mapViewCoordinator.start()
        window.makeKeyAndVisible()
    }

    
}
