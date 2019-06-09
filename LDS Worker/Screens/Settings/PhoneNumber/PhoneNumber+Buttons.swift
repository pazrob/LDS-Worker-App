//
//  PhoneNumber+Buttons.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PhoneNumberController {
    
    @objc func handleDeletePhone() {
        
        //Delete on Database
        FirebaseService.deletePhoneNumber { success in
            
            if success {
                self.mainView.phoneTextField.text = ""
                self.updateViewBaseOnPhone()
            } else {
                print("Phone NOT DELETED")
            }
        }
    }
    
}
