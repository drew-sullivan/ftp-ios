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
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
    }
    
    
}
