//
//  SessionDetailViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/15/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class SessionDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var numberField: UITextField!
    @IBOutlet var dateRecorded: UILabel!
    @IBOutlet var timeRecorded: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    var session: Session! {
        didSet {
            navigationItem.title = "Session No. \(session.num)"
        }
    }
    
    // MARK: - lifecycle hooks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateRecorded.text = ObjectFormatter.formatDate(from: session.date)
        timeRecorded.text = ObjectFormatter.formatTime(from: session.date)
        numberField.text = "\(session.numShotsMade)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // dismiss keyboard gracefully, if open
        view.endEditing(true)
        
        if let numFieldText = numberField.text, let value = Int(numFieldText) {
            session.numShotsMade = value
        } else {
            session.numShotsMade = 0
        }
    }
    
    // MARK: - dismiss keyboard when pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
