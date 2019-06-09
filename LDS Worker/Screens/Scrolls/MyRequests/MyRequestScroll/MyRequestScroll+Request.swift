//
//  MyRequestScroll+Request.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestVC {
    
    func setUpCreateRequestButton() {
        
        createRequestButton.translatesAutoresizingMaskIntoConstraints = false
        myrequestCollectionView.addSubview(createRequestButton)
        
        createRequestButton.widthAnchor.constraint(equalTo: myrequestCollectionView.widthAnchor, constant: 0).isActive = true
        createRequestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createRequestButton.bottomAnchor.constraint(equalTo: myrequestCollectionView.topAnchor, constant: 0).isActive = true
    }
    
    @objc func handleRequestButton() {
        
        if FirebaseService.currentUserProfile?.phone == nil {
            
            let actionAlert = UIAlertController(title: "Set up your phone number",
                                                message: "You must provide a phone number in order to make requests.",
                                                preferredStyle: .alert)
            
            let addPhone = UIAlertAction(title: "Add phone", style: .default) { alert in
                let phoneVC = PhoneNumberController()
                phoneVC.modalMode = true
                let phoneNC = UINavigationController(rootViewController: phoneVC)
                phoneNC.navigationBar.isTranslucent = false
                
                self.present(phoneNC, animated: true, completion: nil)
                
            }
            
            let later = UIAlertAction(title: "Maybe later", style: .default, handler: nil)
            
            actionAlert.addAction(addPhone)
            actionAlert.addAction(later)
            
            self.present(actionAlert, animated: true, completion: nil)
            return
            
        }
        
        systemLikeAnimation()
//        self.handleNewRequestButton()
    }
    
    func systemLikeAnimation() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.createRequestButton.iconAdd.alpha = 0.2
            self.createRequestButton.viewLabel.alpha = 0.2
        }) { done in
            self.createRequestButton.iconAdd.alpha = 1
            self.createRequestButton.viewLabel.alpha = 1
        }
    }
    
}
