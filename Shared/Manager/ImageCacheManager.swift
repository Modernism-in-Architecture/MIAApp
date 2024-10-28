//
//  ImageCacheManager.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 03.07.23.
//

import UIKit
import OSLog

public class ImageCacheManager {

    static let instance = ImageCacheManager()
    private init() {}

    private var cache: NSCache<NSString, WrappedImage> = {
        
        var cache = NSCache<NSString, WrappedImage>()
        cache.countLimit = MIADefaults.ImageCache.countLimit
        cache.totalCostLimit = MIADefaults.ImageCache.totalCostLimit
        return cache
    }()

    func add(image: UIImage, for url: URL, until expirationDate: Date) {
        
        Logger.cache.debug("Save image for url: \(url)")
        
        let cacheObject = WrappedImage(image: image, expirationDate: expirationDate)
        let key = NSString(string: url.absoluteString)
        cache.setObject(cacheObject, forKey: key)
    }

    func get(url: URL) -> UIImage? {
        
        Logger.cache.debug("get image for url: \(url)")
        
        let key = NSString(string: url.absoluteString)
        
        guard let wrappedImage = cache.object(forKey: key) else {
            return nil
        }
        
        if wrappedImage.expirationDate < Date.now {
            cache.removeObject(forKey: key)
            return nil
        }
        return wrappedImage.image
    }
}

class WrappedImage {
    
    let image: UIImage
    let expirationDate: Date

    init(image: UIImage, expirationDate: Date) {
        
        self.image = image
        self.expirationDate = expirationDate
    }
}
