//
//  Session.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class Session: NSObject {
    var key: UUID
    var num: Int
    var date: Date
    var numShotsMade: Int

    init(num: Int, date: Date, numShotsMade: Int) {
        self.key = UUID()
        self.num = num
        self.date = date
        self.numShotsMade = numShotsMade
        
        super.init()
    }
    
    convenience init(random: Bool = false, num: Int) {
        if random {
            let randInt = Int(arc4random_uniform(10))
            self.init(num: num, date: Date(), numShotsMade: randInt)
        } else {
            self.init(num: num, date: Date(), numShotsMade: 8)
        }
    }
}
