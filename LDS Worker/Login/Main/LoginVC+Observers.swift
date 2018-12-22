//
//  LoginVC+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    
    //Observe keyborad movements
    func addKeyboardObservers(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height >= 2436 ||
                UIScreen.main.nativeBounds.height >= 2688 ||
                UIScreen.main.nativeBounds.height == 1792 {
                return
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    @objc func keyboardNotification(notification: NSNotification){
        
        //Get bool value for keyboard showing
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        if isKeyboardShowing {
            collectionTopConstraint?.constant = 50
            iconWidthAnchor?.constant = 100
            iconHeightAnchor?.constant = 100
            iconBottomAnchor?.constant = 70
            iconCenterAnchor?.isActive = false
            iconLeftAnchor?.isActive = true
        } else {
            collectionTopConstraint?.constant = 200
            iconWidthAnchor?.constant = 130
            iconHeightAnchor?.constant = 130
            iconBottomAnchor?.constant = 0
            iconCenterAnchor?.isActive = true
            iconLeftAnchor?.isActive = false
        }

        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}
