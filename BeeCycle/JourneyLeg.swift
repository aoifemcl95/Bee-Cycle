//
//  JourneyLeg.swift
//  BeeCycle
//
//  Created by Aoife McLaughlin on 04/01/2019.
//  Copyright © 2019 Aoife McLaughlin. All rights reserved.
//

import UIKit

class JourneyLeg: NSObject {

    var turn: String?
    var duration: Int?
    var distance: String?
    var name: String?
    
    init(turn: String?, distance: String?, duration: Int?, name:String?)
    {
        self.turn = turn
        self.name = name
        self.duration = duration
        self.distance = distance
    }
}
