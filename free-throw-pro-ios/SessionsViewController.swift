//
//  SessionsViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/13/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class SessionsViewController: UITableViewController {
    
    var sessionsStore: SessionStore!
    
    
    // MARK: - tableView config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let session = sessionsStore.allSessions[indexPath.row]
        cell.textLabel?.text = "\(session.date)"
        cell.detailTextLabel?.text = "\(session.outOf10)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsStore.allSessions.count
    }
}
