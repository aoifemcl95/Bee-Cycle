//
//  BottomSheetViewController.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 24/07/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController{
    

    @IBOutlet weak var takeMeButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var journeyPlannerResult: JourneyPlannerResult
    
    override func viewDidLoad() {
        let journeyName = (journeyPlannerResult.startName != nil) ? journeyPlannerResult.name! : ""
        self.directionsLabel.text = journeyName
        let durationString = String(journeyPlannerResult.duration!)
        let durationMinString = journeyPlannerResult.duration! > 1 ? "\(durationString) mins" : "\(durationString) min"
        self.durationLabel.text = durationMinString
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture(recognizer:)))
        self.contentView.addGestureRecognizer(gesture)
        super.viewDidLoad()
    }
    
    init(journeyPlannerResult: JourneyPlannerResult)
    {
        self.journeyPlannerResult = journeyPlannerResult
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        Bundle.main.loadNibNamed("BottomSheetViewController", owner: self, options: nil)
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture(recognizer:)))
//        contentView.addGestureRecognizer(gesture)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        self.journeyPlannerResult = journeyPlannerResult
//        super.init(coder: aDecoder)
//    }

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
        takeMeButton.alpha = 0
         directionsLabel.text = routeDirections
    }
    
    func showDurationOfRoute(timeInMinutes: String)
    {
        takeMeButton.alpha = 0
        durationLabel.text = timeInMinutes
    }
    @IBAction func takeMeTapped(_ sender: Any) {
        
    }
    
    
    // Table View delegate methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
}
