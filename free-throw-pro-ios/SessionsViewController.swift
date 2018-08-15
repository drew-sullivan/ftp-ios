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
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        return df
    }()
    
    let timeFormatter: DateFormatter = {
        let tf = DateFormatter()
        tf.dateStyle = .none
        tf.timeStyle = .medium
        return tf
    }()
    
    // MARK: - Button Actions
    @IBAction func addNewItem(_ sender: UIButton) {
        let newSession = sessionsStore.createSession()
        if let index = sessionsStore.allSessions.index(of: newSession) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    // MARK: - lifecycle hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    
    // MARK: - tableView config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell
        let session = sessionsStore.allSessions[indexPath.row]
        
        cell.dateLabel.text = dateFormatter.string(from: session.date)
        cell.dateLabel.text = Utility.formatDate(date: session.date)
        cell.timeLabel.text = timeFormatter.string(from: session.date)
        cell.numShotsMadeLabel.text = String(session.numShotsMade)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsStore.allSessions.count
    }
    
    // MARK: - delete session
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let session = sessionsStore.allSessions[indexPath.row]
            
            let title = "Delete \(session.date) - \(session.numShotsMade)?"
            let message = "Are you sure you want to delete this session?"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action) -> Void in
                    self.sessionsStore.removeSession(session)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alert.addAction(deleteAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - move session
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sessionsStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    
}
