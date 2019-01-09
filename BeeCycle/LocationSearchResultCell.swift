//
//  LocationSearchResultCell.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 23/08/2018.
//  Copyright © 2018 Aoife McLaughlin. All rights reserved.
//

import UIKit

class LocationSearchResultCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var searchResultLabel: UILabel!
    override func awakeFromNib() {
//        self.prepareBackgroundView()
        super.awakeFromNib()
//        self.searchResultLabel.text = nil
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareBackgroundView()
    {
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = self.bounds
        bluredView.frame = self.bounds
        self.insertSubview(bluredView, at: 0)
    }
    
    func updateLabelForResultName(name:String)
    {
        self.searchResultLabel.text = name
    }
    
}
