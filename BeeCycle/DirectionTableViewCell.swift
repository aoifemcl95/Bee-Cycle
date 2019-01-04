//
//  DirectionTableViewCell.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 04/01/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

    @IBOutlet weak var directionImageView: UIImageView!
    
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellForJourneyLeg(journeyLeg: JourneyLeg)
    {
        if (journeyLeg.turn == "turn right")
        {
            directionImageView.image = UIImage(named: "turn-right")
        }
        else if (journeyLeg.turn == "turn left")
        {
            directionImageView.image = UIImage(named: "turn-left")
        }
        else if (journeyLeg.turn == "straight on")
        {
            directionImageView.image = UIImage(named: "straight-on")
        }
        else
        {
            directionImageView.image = nil
        }
        directionLabel.text = journeyLeg.turn
        let distanceString = journeyLeg.distance
        distanceLabel.text = (distanceString != nil) ? "\(distanceString!) metres" : ""
    }
    
}
