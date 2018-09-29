//
//  LoginVC+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension LoginViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView(){
        
        //Get access to the layout
        if let flowLayout = loginCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        //Allows snap on horizontal cells
        loginCollection.isPagingEnabled = true
        loginCollection.showsHorizontalScrollIndicator = false
        
        //Selects the fist icon on menu
        isFirstCellActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: loginCollection.frame.width, height: loginCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let scroll1 = loginCollection.dequeueReusableCell(withReuseIdentifier: registerCellId, for: indexPath) as! RegisterCollectionCell
            scroll1.loginViewController = self
            return scroll1
        }
        else {
            let scroll2 = loginCollection.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCollectionCell
            scroll2.loginViewController = self
            return scroll2
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.x > 0) {
            loginLabel.isHidden = false
            isFirstCellActive = false
        } else {
            loginLabel.isHidden = true
            isFirstCellActive = true
        }
        
        registerLabel.alpha = 1 - ( (scrollView.contentOffset.x / 375) * 2 )
        loginLabel.alpha = ( scrollView.contentOffset.x * 2 ) / 375
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    @objc func handleRegisterSwipe(){
        loginCollection.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
    
    @objc func handleLoginSwipe(){
        loginCollection.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
}
