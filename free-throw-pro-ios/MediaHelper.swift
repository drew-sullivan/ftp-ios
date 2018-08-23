//
//  MediaHelper.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/20/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class MediaHelper {
    
    static func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerControllerSourceType) {
        
        let mediaUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            mediaUI.sourceType = sourceType
        } else {
            mediaUI.sourceType = .photoLibrary
        }
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
    }
    
    
}
