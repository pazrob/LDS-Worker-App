//
//  ImageService.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    
    static var userPhoto = UIImage(named: "defaultPortrait")
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()){
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()){
     
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
        
    }
    
    static func loadUserPicture(){
        guard let currentUser = FirebaseService.currentUserProfile else {return}
        
        if let urlString = currentUser.imageURL {
            let imageURL = URL(string: urlString)
            ImageService.getImage(withURL: imageURL!) { (userPhoto) in
                self.userPhoto = userPhoto
            }
        }
    }
    
}
