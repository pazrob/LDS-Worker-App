//
//  HomeController+MenuBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension HomeController {
    
    func setUpMenuBar(){
        
        view.addSubview(menuBar)
        menuBar.anchor(view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                       topConstant: -50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionView.ScrollPosition(rawValue: 0), animated: true)
    }
}
