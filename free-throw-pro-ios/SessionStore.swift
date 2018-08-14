//
//  SessionStore.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class SessionStore {
    
    var allSessions = [Session]()
    
    init() {
        for _ in 0..<5 {
            createSession()
        }
    }
    
    @discardableResult func createSession() -> Session {
        let newSession = Session(random: true)
        allSessions.append(newSession)
        return newSession
    }
    
    func removeSession(_ session: Session) {
        if let index = allSessions.index(of: session) {
            allSessions.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allSessions[fromIndex]
        allSessions.remove(at: fromIndex)
        allSessions.insert(movedItem, at: toIndex)
    }
}
