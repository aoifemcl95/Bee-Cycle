//
//  BottomSheetViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 24/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit
import MapKit

class BottomSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var journeyPlannerResult: JourneyPlannerResult
    var mapItem: MKMapItem
    
    override func viewDidLoad() {
        let journeyName = "Current Location to \(String(describing: mapItem.placemark.name!))"
        self.directionsLabel.text = journeyName
        let durationString = String(journeyPlannerResult.duration!)
        let durationMinString = journeyPlannerResult.duration! > 1 ? "\(durationString) mins" : "\(durationString) min"
        self.durationLabel.text = durationMinString
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture(recognizer:)))
        self.contentView.addGestureRecognizer(gesture)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DirectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        super.viewDidLoad()
    }
    
    init(journeyPlannerResult: JourneyPlannerResult, mapItem: MKMapItem)
    {
        self.journeyPlannerResult = journeyPlannerResult
        self.mapItem = mapItem
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }


    func prepareBackgroundView()
    {
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y+translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    

    func updateDirectionsForLabel(routeDirections: String)
    {
         directionsLabel.text = routeDirections
    }
    
    func showDurationOfRoute(timeInMinutes: String)
    {
        durationLabel.text = timeInMinutes
    }
    
    
    // Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeyPlannerResult.journeyLegs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = DirectionTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DirectionTableViewCell
        cell.updateCellForJourneyLeg(journeyLeg: journeyPlannerResult.journeyLegs[indexPath.row])
        return cell
    }
    
}
