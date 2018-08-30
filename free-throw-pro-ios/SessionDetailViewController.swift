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
    
    @IBAction func recordVideo(_ sender: UIBarButtonItem) {
        MediaHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        let videoInfo = mediaStore.video(forKey: session.key)
        let url = videoInfo?.videoURL
        let player = AVPlayer(url: url!)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
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
        let videoData = mediaStore.video(forKey: key)
        let videoSnapshotToDisplay = getVideoSnapshot(fromVideoLocation: videoData!.videoURL!)
        imageView.image = videoSnapshotToDisplay
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard
            let mediaType = info[UIImagePickerControllerMediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerControllerMediaURL] as? URL,
            let videoData = NSData(contentsOf: url),
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else {
                return
        }
        
        let videoSnapshot = getVideoSnapshot(fromVideoLocation: url)
        
        self.dismiss(animated: true, completion: nil)
        
        mediaStore.setVideo(videoData: videoData, forKey: session.key)
        imageView.image = videoSnapshot
    
        dismiss(animated: true, completion: {
            let player = AVPlayer(url: url)
            let vcPlayer = AVPlayerViewController()
            vcPlayer.player = player
            self.present(vcPlayer, animated: true, completion: nil)
        })

        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // MARK: - Helpers
    @objc func getVideoSnapshot(fromVideoLocation url: URL) -> UIImage? {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 0, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
            
        } catch let error as NSError {
            print("Error: \(error)")
            return nil
        }
    }

    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        print(message)

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
