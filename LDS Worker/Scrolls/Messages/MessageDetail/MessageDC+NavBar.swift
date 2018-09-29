//
//  MessageDC+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MessageDetailController {
    
    func setUpNavigationBar() {
        
        //Title View
        self.navigationItem.titleView = navView
        
        setUpPartnerInfo()
    }
    
    func setUpPartnerInfo() {
        
        //Title text
        if let name = partnerUser?.firstName, let last = partnerUser?.lastName {
            navView.navNameLabel.text = "\(last), \(name)"
        }
        
        //Title photo
        if let photoString = partnerUser?.photoURL, let photoURL = URL(string: photoString) {
            
            //Fetch photo
            ImageService.getImage(withURL: photoURL) { partnerPicture in
                
                //If fails
                if partnerPicture == nil {
                    
                    self.navView.navPicture.image = UIImage.getGenderPhotoDefault(gender: self.partnerUser?.gender ?? "m")
                    return
                }
                
                //If succeeds
                self.navView.navPicture.image = partnerPicture
            }
            
        } else {
            // If no title photo, or url is found
            self.navView.navPicture.image = UIImage.getGenderPhotoDefault(gender: self.partnerUser?.gender ?? "m")
        }
    }
    

}
