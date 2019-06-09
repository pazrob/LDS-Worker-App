//
//  MyRequestDC+2.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestDetailController {
    
    func loadContent() {
        
        //Get if post expired
        if let postDeadline = postDetails?.from {
            let timestamp = Date().timeIntervalSince1970
            isExpired = timestamp > postDeadline
        }
        
        //User photo
        if let userPhoto = ImageService.userPhoto {
            myRequestDetailView.profilePicture.image = userPhoto
            
        } else {
            myRequestDetailView.profilePicture.image = UIImage(named: ImageService.defaultPhotoString)
        }
        
        //Name
        if let last = postDetails?.lastName, let first = postDetails?.firstName {
            myRequestDetailView.nameLabel.text = "\(last), \(first)"
        }
        
        //Timestamp
        if let seconds = postDetails?.timeStamp {
            let dateString = Date.getTimeStamp(with: seconds)
            myRequestDetailView.posted.text = "Posted \(dateString)"
        }
        
        //Note
        if let description = postDetails?.note {
            myRequestDetailView.noteField.text = description
        }
        
        //Dates
        if postDetails?.from != nil {
            myRequestDetailView.fromField.text = postDetails?.getFromString()
        }
        if let to = postDetails?.to {
            myRequestDetailView.toField.text = to
        }
        
        //Status
        if postDetails?.status != nil {
            updateStatus()
        }
        
        //Expiration
        if isExpired {
            
            //Update post
            myRequestDetailView.posted.textColor = UIColor.appUncovered
            myRequestDetailView.posted.font = UIFont.boldSystemFont(ofSize: 13)
            myRequestDetailView.posted.text = "THIS REQUEST EXPIRED"
            
            //Disable status button
            myRequestDetailView.statusButton.backgroundColor = UIColor.lightGray
            myRequestDetailView.statusButton.isEnabled = false
            myRequestDetailView.statusButton.alpha = 0.3
            
            //Advertise delete button
            myRequestDetailView.deleteButton.backgroundColor = UIColor.appMainColor
            myRequestDetailView.deleteButton.layer.borderWidth = 0
            myRequestDetailView.deleteButton.setTitleColor( .white, for: .normal)
            
        }
    }
    
    
}
