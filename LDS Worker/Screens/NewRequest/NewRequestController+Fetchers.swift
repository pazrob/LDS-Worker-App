//
//  NewRequestController+Fetchers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension NewRequestController {
    
    func fetchDataToEdit() {
        
        if let editRequest = requestToEdit {
            if let note = editRequest.note{
                mainView.counterLabel.text = "\(note.count)/\(MAX_CHARACTERS)"
                mainView.noteField.text = note
            }
            if let from = editRequest.from {
                mainView.dateField.text = requestToEdit?.getFromString()
                
                //Equal dates
                let date = Date(timeIntervalSince1970: from)
                mainView.datePicker.date = date
            }
            if let to = editRequest.to{
                mainView.timeField.text = to
                
                //Equal time
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                if let time = formatter.date(from: to) {
                    mainView.timePicker.date = time
                }
            }
        }
    }
    
    func setUpUserInfo(){
        
        guard let currentUser = FirebaseService.currentUserProfile else { return }
        
        mainView.nameLabel.text = "\(currentUser.firstName) \(currentUser.lastName)"
        mainView.templeLabel.text = currentUser.temple
        
        //If there is phone
        if let phone = currentUser.phone {
            mainView.phoneLabel.text = String.getNumberedFormated(phone: phone)
            
        } else {
            //No phone found
            mainView.phoneLabel.text = "No phone numbered was found"
            mainView.phoneLabel.textColor = UIColor.red
        }
        
        if let userPhoto = ImageService.userPhoto {
            mainView.profilePicture.image = userPhoto
        }
    }
}
