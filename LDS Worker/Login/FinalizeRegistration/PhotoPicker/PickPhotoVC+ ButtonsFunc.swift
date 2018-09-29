//
//  PickPhotoVC+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickPhotoViewController {

    
    @objc func handleUploadPhoto(){
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func handleFinalize() {
        
        //MARK: DISABLE OTHER ACTIONS
        registerButton.setTitle("REGISTERING...", for: .normal)
        
        // All information is gathered, proceed to register
        guard let user = potentialUser else { return }        
        completeRegistration(potentialUser: user, isTherePhoto: isPhotoSelected)
        // Pass the information about the temple, and gender maybe? or all info
        
        
        
    }
    
}
