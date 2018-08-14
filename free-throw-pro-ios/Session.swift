//
//  Session.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class Session: NSObject {
    var id: UUID
    var date: Date
    var numShotsMade: Int

    init(date: Date, numShotsMade: Int) {
        self.id = UUID()
        self.date = date
        self.numShotsMade = numShotsMade
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let randInt = Int(arc4random_uniform(10))
            self.init(date: Date(), numShotsMade: randInt)
        } else {
            self.init(date: Date(), numShotsMade: 8)
        }
    }
}
