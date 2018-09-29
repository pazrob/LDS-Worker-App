//
//  UIImage+Extensions.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func getGenderPhotoDefault(gender: String) -> UIImage {
        
        if gender == "m" {
            return UIImage(imageLiteralResourceName: PictureKeys.brotherDefault.rawValue)
            
        } else {
            return UIImage(imageLiteralResourceName: PictureKeys.sisterDefault.rawValue)
        }
    }
    
}
