//
//  PanelOptionsViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import Panels
import MapKit


class PanelOptionsViewController: UIViewController, Panelable {
    @IBOutlet weak var panelLabel: UILabel!
    @IBOutlet weak var headerPanel: UIView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    let mapViewController = MapViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapViewController.panelDelegate = self
        // Do any additional setup after loading the view.
    }


}

extension PanelOptionsViewController : MapViewTitleDelegate
{
    func configurePanelTitle(mapItem: MKMapItem) {
        panelLabel.text = mapItem.placemark.name
    }
}


