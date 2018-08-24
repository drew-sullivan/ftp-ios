//
//  Session.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class Session: NSObject, NSCoding {
    var key: String
    var num: Int
    var date: Date
    var numShotsMade: Int

    init(num: Int, date: Date, numShotsMade: Int) {
        self.key = UUID().uuidString
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
    
    // MARK: - Archiving
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "key")
        aCoder.encode(num, forKey: "num")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(numShotsMade, forKey: "numShotsMade")
    }
    
    required init?(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObject(forKey: "key") as! String
        num = aDecoder.decodeObject(forKey: "num") as! Int
        date = aDecoder.decodeObject(forKey: "date") as! Date
        numShotsMade = aDecoder.decodeObject(forKey: "numShotsMade") as! Int
        
        super.init()
    }
}
