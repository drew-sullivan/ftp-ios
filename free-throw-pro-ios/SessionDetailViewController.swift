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
    
    var session: Session!
    
    // MARK: - lifecycle hooks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateRecorded.text = ObjectFormatter.formatDate(from: session.date)
        timeRecorded.text = ObjectFormatter.formatTime(from: session.date)
        numberField.text = "\(session.numShotsMade)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
