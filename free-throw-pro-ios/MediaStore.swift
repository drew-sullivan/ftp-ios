//
//  MediaStore.swift
//  free-throw-pro-ios
//
//  Created by Drew Sullivan on 8/20/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

import UIKit

class MediaStore {
    
    let cache = NSCache<NSString, Video>()
    
    func setVideo(by snapshotImage: UIImage, url videoURL: URL, forKey key: String) {
        let video = Video(snapshot: snapshotImage, url: videoURL)
        cache.setObject(video, forKey: key as NSString)
    }
    
    func video(forKey key: String) -> Video? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteVideo(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
