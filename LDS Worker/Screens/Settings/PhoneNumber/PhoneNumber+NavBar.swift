//
//  PhoneNumber+NavBar.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PhoneNumberController {
    
    
    func setUpNavBar() {
        
        if let modal = modalMode, modal {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(handleDismiss))
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(handleSavePhone))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    
    @objc func handleSavePhone() {
        
        if let formatedNumbers = mainView.phoneTextField.text {
            
            let phoneNumber = String.filterDigitsIntoString(from: formatedNumbers)
            
            FirebaseService.updatePhoneNumber(phoneNumber: phoneNumber) { success in
                
                if success {
                    //Update Localy
                    FirebaseService.currentUserProfile?.phone = phoneNumber
                    
                    //Update Views
                    self.updateViewBaseOnPhone()
                    
                    //Resign responder
                    self.mainView.phoneTextField.resignFirstResponder()
                    
                    //Leave ViewController base on mode of presentation. Both are success.
                    //First one is when Controller is presented as a Modal
                    //Second one is when Controller is pushed in Nav Controller
                    if let modal = self.modalMode, modal {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    } else {
                        self.view.endEditing(true)
                    }
                    
                } else {
                    //Failed
                    UIAlertController.somethingWentWrongController(viewController: self)
                }
            }
            
        }
    }
    
    
    @objc func handleDismiss() {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
