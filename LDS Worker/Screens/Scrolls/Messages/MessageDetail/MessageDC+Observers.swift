//
//  MessageDC+helpers.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/29/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension MessageDetailController {
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification: Notification) {
        
        if let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            }) { completed in
                if completed {
//                    self.scrollToLatestText(withAnimation: true)
                    self.collectionView?.scrollToLast(withAnimation: true)
                }
            }
        }
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}


