//
//  DownloadHelpers.swift
//  YPImagePicker
//
//  Created by Quang on 1/18/19.
//  Copyright © 2019 Yummypets. All rights reserved.
//

import Foundation
import UIKit

class DownloadHelpers {
    class func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        } else {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request) { (data, response, error) in
                if let _ = error {
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            task.resume()
        }
    }
}
