//
//  Utility.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/15/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import Foundation

class Utility {
    
    let df: DateFormatter() = {
        df.dateStyle = .long
        df.timeStyle = .none
    }
    
    
    let tf = DateFormatter()
    tf.dateStyle = .none
    tf.timeStyle = .medium
    
    func formatDate(date: Date) -> String {
        return df.string(from: date)
    }
    
    func formatTime(date: Date) -> String {
        return tf.string(from: date)
    }
}
