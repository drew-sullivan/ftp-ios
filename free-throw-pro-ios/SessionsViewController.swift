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
    var mediaStore: MediaStore!
    
    // Adding edit button in nav bar
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Button Actions
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let newSession = sessionsStore.createSession()
        if let index = sessionsStore.allSessions.index(of: newSession) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - lifecycle hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    // MARK: - tableView config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell
        let session = sessionsStore.allSessions[indexPath.row]
        
        cell.sessionNumLabel.text = "\(session.num)"
        cell.dateLabel.text = ObjectFormatter.formatDate(from: session.date)
        cell.timeLabel.text = ObjectFormatter.formatTime(from: session.date)
        cell.numShotsMadeLabel.text = "\(session.numShotsMade)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsStore.allSessions.count
    }
    
    // MARK: - delete session
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let session = sessionsStore.allSessions[indexPath.row]
            
            let title = "Delete Session \(session.num)?"
            let message = "Are you sure you want to delete this session?"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action) -> Void in
                    self.sessionsStore.removeSession(session)
                    self.mediaStore.deleteVideo(forKey: session.key)
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
    
    //MARK: - segue to SessionDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showSession"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let session = sessionsStore.allSessions[row]
                let sessionDetailViewController = segue.destination as! SessionDetailViewController
                sessionDetailViewController.session = session
                sessionDetailViewController.mediaStore = mediaStore
            }
        default:
            preconditionFailure("Unexpected segue identifier. Expected: showSession")
        }
    }
    
}
