//
//  LoginController+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/11/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func setUpNavigationBar(){
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func addKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Implements observers action
    @objc func keyboardNotification(notification: NSNotification){
        let scrollUpConstant: CGFloat = -155 - 80
        let scrollIconConstant: CGFloat = -200
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        collectionBottomConstraint?.constant = isKeyboardShowing ? scrollUpConstant : -80
        menuCollectionView.isScrollEnabled = isKeyboardShowing ? false : true
        if isFirstCellActive == true {
            iconTopConstraint?.constant = isKeyboardShowing ? scrollIconConstant : 130
        } else {
            iconTopConstraint?.constant = isKeyboardShowing ? scrollIconConstant : 75
        }
        
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    
    // >>> Collection Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: menuCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let scroll1 = menuCollectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCollectionCell
            scroll1.loginViewController = self
            return scroll1
        }
        else {
            let scroll2 = menuCollectionView.dequeueReusableCell(withReuseIdentifier: registerCellId, for: indexPath) as! RegisterCollectionCell
            scroll2.loginViewController = self
            return scroll2
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.x > 0){
            loginLabel.isHidden = false
            isFirstCellActive = false
        } else {
            loginLabel.isHidden = true
            isFirstCellActive = true
        }
        iconTopConstraint?.constant = 130 - (scrollView.contentOffset.x * 0.16)
        registerLabel.alpha = 1 - ( (scrollView.contentOffset.x / 375) * 2 )
        loginLabel.alpha = ( scrollView.contentOffset.x * 2) / 375
    }
    //Control Pages with menu
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true) }
}
