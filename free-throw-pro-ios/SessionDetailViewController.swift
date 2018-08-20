//
//  SessionDetailViewController.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/15/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices

class SessionDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var numberField: UITextField!
    @IBOutlet var dateRecorded: UILabel!
    @IBOutlet var timeRecorded: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        MediaHelper.startMediaBrowser(delegate: self, sourceType: .camera)
        
//        let imagePicker = UIImagePickerController()
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//        } else {
//            imagePicker.sourceType = .photoLibrary
//        }
//
//        imagePicker.delegate = self
//
//        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        MediaHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    var session: Session! {
        didSet {
            navigationItem.title = "Session No. \(session.num)"
        }
    }
    
    var mediaStore: MediaStore!
    
    // MARK: - lifecycle hooks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateRecorded.text = ObjectFormatter.formatDate(from: session.date)
        timeRecorded.text = ObjectFormatter.formatTime(from: session.date)
        numberField.text = "\(session.numShotsMade)"
        
        let key = session.key
        let imageToDisplay = mediaStore.image(forKey: key)
        imageView.image = imageToDisplay
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
    
    // MARK: - UIImagePickerControllerDelegate
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        mediaStore.setImage(image, forKey: session.key)
//        imageView.image = image
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard
            let mediaType = info[UIImagePickerControllerMediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerControllerMediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else {
                return
        }
        
        dismiss(animated: true, completion: {
            let player = AVPlayer(url: url)
            let vcPlayer = AVPlayerViewController()
            vcPlayer.player = player
            self.present(vcPlayer, animated: true, completion: nil)
        })

        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        print(message)

//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//
//        present(alert, animated: true, completion: nil)
    }
}
