//
//  Video.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/22/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class Video : NSObject {
    var snapshot: UIImage
    var url: URL
    
    init(snapshot: UIImage, url: URL) {
        self.snapshot = snapshot
        self.url = url
    }
}
