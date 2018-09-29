//
//  ImageView+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIImageView{
    
    static func getProfileFrame(with name: String?) -> UIImageView{
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50 //imageView.bounds.height / 2
        imageView.contentMode = .scaleAspectFill
        if let theName = name {
            imageView.image = UIImage(named: theName)
        }        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func loadImageUsingStringURL(urlString: String){
        
        image = nil
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //check for error
            if(error != nil){
                return
            }
            let imageToCache = UIImage(data: data!)
            self.image = imageToCache
            
        }
    }
}
