//
//  RecordVideoViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/20/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {
    
    @IBAction func record(_ sender: AnyObject) {
        MediaHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    
}

extension RecordVideoViewController: UIImagePickerControllerDelegate {

}

extension RecordVideoViewController: UINavigationControllerDelegate {

}
