//
//  LocationSearchResultCell.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 23/08/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

class LocationSearchResultCell: UITableViewCell {

    @IBOutlet weak var searchResultLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.searchResultLabel.text = nil
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateLabelForResultName(name:String)
    {
        self.searchResultLabel.text = name
    }
    
}
