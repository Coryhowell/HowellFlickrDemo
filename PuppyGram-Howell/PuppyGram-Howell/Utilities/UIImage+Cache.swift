//
//  UIImage+Cache.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/5/22.
//

import UIKit.UIImage

extension UIImage {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func cache(with key: String) {
        UIImage.imageCache.setObject(self, forKey: key as AnyObject)
    }
    
    func remove(with key: String) {
        UIImage.imageCache.removeObject(forKey: key as AnyObject)
    }
}
