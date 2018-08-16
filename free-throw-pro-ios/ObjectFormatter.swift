//
//  Utility.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/15/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import Foundation

class ObjectFormatter {
    
    static func formatDate(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        return df.string(from: date)
    }
    
    static func formatTime(from date: Date) -> String {
        let tf = DateFormatter()
        tf.dateStyle = .none
        tf.timeStyle = .medium
        return tf.string(from: date)
    }
    
    static func formatDate(from string: String) -> Date {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return (df.date(from: string))!
    }
}
