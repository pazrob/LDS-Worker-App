//
//  GroupRequestDC+DidSet.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension GroupRequestDetailController {
    
    func handleDidSet() {
        
        //Name
        if let last = postDetails?.lastName, let first = postDetails?.firstName{
            requestDetailView.nameLabel.text = "Brother \(last), \(first)"
        }
        
        //Date posted
        if let postedOn = postDetails?.timeStamp{
            let dateString = Date.getTimeStamp(with: postedOn)
            requestDetailView.posted.text = "Posted \(dateString)"
        }
        
        //Note
        if let description = postDetails?.note{
            requestDetailView.noteField.text = description
        }
        
        //Dates
        if postDetails?.from != nil {
            requestDetailView.fromField.text = postDetails?.getFromString()
        }
        if let to = postDetails?.to {
            requestDetailView.toField.text = to
        }
        
        //Status
        if let isCovered = postDetails?.status{
            if(isCovered){
                requestDetailView.statusField.text = AppContent.statusPositive.rawValue
                requestDetailView.statusField.textColor = UIColor.appMainColor
            }
            else{
                requestDetailView.statusField.text = AppContent.statusNegative.rawValue
                requestDetailView.statusField.textColor = UIColor.appUncovered
            }
        }
        
        //Photo
        if let URLString = postDetails?.imageURL{
            if let imageURL = URL(string: URLString) {
                ImageService.getImage(withURL: imageURL) { profilePic in
                    
                    if profilePic == nil {
                        if let gender = self.postDetails?.gender {
                            self.requestDetailView.profilePicture.image = (gender == "m") ? UIImage(named: PictureKeys.brotherDefault.rawValue) : UIImage(named: PictureKeys.sisterDefault.rawValue)
                        }
                        return
                    }
                    self.requestDetailView.profilePicture.image = profilePic
                }
            }
        } else {
            
            if let gender = postDetails?.gender {
                self.requestDetailView.profilePicture.image = (gender == "m") ? UIImage(named: PictureKeys.brotherDefault.rawValue) : UIImage(named: PictureKeys.sisterDefault.rawValue)
            }
            
        }
    }
    
}
