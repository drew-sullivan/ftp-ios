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
    let sessionArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("sessions.archive")
    }()
    
    init() {
        for _ in 0..<5 {
            createSession()
        }
    }
    
    @discardableResult func createSession() -> Session {
        let newSession = Session(random: true, num: allSessions.count + 1)
        allSessions.insert(newSession, at: 0)
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
    
    // MARK: - Archive
    func saveChanges() -> Bool {
        print("Saving sessions to: \(sessionArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allSessions, toFile: sessionArchiveURL.path)
    }
}
