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
         directionLabel.text = journeyLeg.turn
        distanceLabel.text = journeyLeg.distance
    }
    
}
