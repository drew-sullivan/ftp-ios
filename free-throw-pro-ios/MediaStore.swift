//
//  MediaStore.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/20/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

struct VideoDataAndLocation {
    let video: NSData
    let videoURL: URL?
}

class MediaStore {
    
    let cache = NSCache<NSString, NSData>()
    
    func setVideo(videoData: NSData, forKey key: String) {
        cache.setObject(videoData, forKey: key as NSString)
        
        let url = videoURL(forKey: key)
        let _ = try? videoData.write(to: url, options: [.atomic])
    }
    
    func video(forKey key: String) -> VideoDataAndLocation? {
        if let existingVideo = cache.object(forKey: key as NSString) {
            return VideoDataAndLocation(video: existingVideo, videoURL: nil)
        }
        
        let url = videoURL(forKey: key)
        guard let videoFromDisk = NSData(contentsOf: url) else {
            return nil
        }
        
        cache.setObject(videoFromDisk, forKey: key as NSString)
        return VideoDataAndLocation(video: videoFromDisk, videoURL: url)
    }
    
    func deleteVideo(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func videoURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        let path = documentDirectory.appendingPathComponent(key)
        return path
    }
}
