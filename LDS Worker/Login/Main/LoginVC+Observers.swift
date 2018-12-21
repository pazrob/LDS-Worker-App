//
//  LoginVC+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    func addKeyboardObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    @objc func keyboardNotification(notification: NSNotification){
        
//        let scrollUpConstant: CGFloat = -100 - 80
//        let scrollIconConstant: CGFloat = 140
//
//        //Get bool value for keyboard showing
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
//
//        collectionBottomConstraint?.constant = isKeyboardShowing ? -200 : 0
//        collectionTopConstraint?.constant = isKeyboardShowing ? 50 : 200
//        iconWidthAnchor?.constant = isKeyboardShowing ? 80 : 130
//        iconHeightAnchor?.constant = isKeyboardShowing ? 80 : 130
//        iconCenterAnchor?.isActive = false
//
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
////        menuCollectionView.isScrollEnabled = isKeyboardShowing ? false : true
//
//        if isFirstCellActive == true {
//            iconBottomAnchor?.constant = isKeyboardShowing ? scrollIconConstant : 130
//        }
        //else {
//            iconTopConstraint?.constant = isKeyboardShowing ? scrollIconConstant : 75
//        }

        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}
