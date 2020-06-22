//
//  AsyncCacheImageProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit
import Foundation

class ImageCacheManager: NSObject
{
    public static let sharedInstance = ImageCacheManager()
    
    let imageCache = NSCache<AnyObject,AnyObject>()
    
    func checkImageInCache(imageName: String) -> UIImage?
    {
        if let imageFromCache = imageCache.object(forKey:imageName as AnyObject) as? UIImage
        {
            return imageFromCache
        }
        
        return nil
    }
    
    func saveImageInCache(imageName: String, imageToCache:UIImage)
    {
        imageCache.setObject(imageToCache, forKey:imageName as AnyObject)
    }
}

extension UIImageView:AsyncCacheImageProtocol
{
    func makeRound()
    {
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
    
    func downloadImage(imageName:String, makeRound:Bool, defaultImageName:String)
    {
        if makeRound == true
        {
            self.makeRound()
        }
        
        if imageName.count < 1
        {
            if let imageFromCache = ImageCacheManager.sharedInstance.checkImageInCache(imageName:imageName)
            {
                self.image = imageFromCache
            }
            else if let defaultImageFromName = UIImage(named:defaultImageName)
            {
                self.image = defaultImageFromName
            }
            else
            {
                self.image = nil
            }
            
            return
        }
        
        if let imageFromCache = ImageCacheManager.sharedInstance.checkImageInCache(imageName:imageName)
        {
            self.image = imageFromCache
            
            return
        }
        
        if let defaultImageFromName = UIImage(named:defaultImageName)
        {
            self.image = defaultImageFromName
        }
        
        RemoteStore.downloadImage(url:imageName, success: { (downloadedImage:UIImage) in
            
            DispatchQueue.main.async
            {
                self.image = downloadedImage
                
                ImageCacheManager.sharedInstance.saveImageInCache(imageName:imageName, imageToCache:downloadedImage)
            }
        }) { (error:Error?) in
            
            DispatchQueue.main.async
            {
                if let defaultImageFromName = UIImage(named:defaultImageName)
                {
                    self.image = defaultImageFromName
                }
                else
                {
                    self.image = nil
                }
            }
        }
    }
}
