//
//  Coordinator.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 30/10/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
