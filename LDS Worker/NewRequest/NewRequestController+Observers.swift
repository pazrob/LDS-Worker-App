//
//  NewRequestController+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension NewRequestController {
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Implements observers action
    @objc private func keyboardNotification(notification: NSNotification){
        
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        mainView.headerTopConstraint?.constant = isKeyboardShowing ? scrollUpConstant : 0
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    //Remove observers
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        self.view.endEditing(true)
    }
}
