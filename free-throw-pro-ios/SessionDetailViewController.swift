//
//  SessionDetailViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/15/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class SessionDetailViewController: UIViewController {
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var timeField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    var session: Session!
    
    // MARK: - lifecycle hooks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        dateField.text = "\(session.date)"
//        timeField.text = "\(session.date)"
//        numberField.text = "\(session.numShotsMade)"
    }
}
