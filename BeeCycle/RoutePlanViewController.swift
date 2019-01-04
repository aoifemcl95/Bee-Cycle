//
//  RoutePlanViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 28/09/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

protocol RoutePlanDidSelectSearchDelegate : class
{
    func routePlanDidSelectSearch()
}

class RoutePlanViewController: UIViewController, UISearchBarDelegate, LocationServiceDelegate {
   
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromButton: UIButton!
    
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toView: UIView!
    var locationSearchTable = LocationSearchTable()
    var resultSearchController: UISearchController? = nil
    var fromTapped: Bool = false
    var toTapped: Bool = false
    var locationService = LocationService()
    var hasGotRegion = false
    var navController = UINavigationController()
    var coordinator: MainCoordinator?
    var mapItem: MKMapItem = MKMapItem()
    weak var delegate : RoutePlanDidSelectSearchDelegate?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fromLabel.text = mapItem.placemark.name
        locationService.delegate = self
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.present(resultSearchController!, animated: true, completion: nil)
    }
    
    
    @IBAction func fromTapped(_ sender: Any) {
        self.fromTapped = true
        self.toTapped = false
        delegate?.routePlanDidSelectSearch()
        
    }
    
    @IBAction func toTapped(_ sender: Any) {
        self.toTapped = true
        self.fromTapped = false
        delegate?.routePlanDidSelectSearch()
    }
    
    func didUpdateLocation() {
        if !hasGotRegion{
            hasGotRegion = true
        }
    }
    
}
