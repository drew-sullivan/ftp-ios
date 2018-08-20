//
//  RecordVideoViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/20/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func record(_ sender: AnyObject) {
        MediaHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard
            let mediaType = info[UIImagePickerControllerMediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerControllerMediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else {
                return
        }
        
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
}
