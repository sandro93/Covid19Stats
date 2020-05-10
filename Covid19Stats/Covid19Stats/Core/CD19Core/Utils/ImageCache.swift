//
//  ImageCache.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/10/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    var task = URLSessionDataTask()
    var session = URLSession.shared
    
    func imageFor(url: URL, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
            completionHandler(imageInCache, nil)
            return
        }
        
        self.task = self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            completionHandler(image, nil)
            
        }
        
        self.task.resume()
    }
}
