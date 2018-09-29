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
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstrainsWithFormat(format: "V:[v0(50)]|", views: menuBar)
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition(rawValue: 0), animated: true)
    }
}
