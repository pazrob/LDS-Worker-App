//
//  MenuBar+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.menuText.text = tabs[indexPath.item]
        let iconName = icons[indexPath.item]
        cell.menuIcon.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        cell.menuIcon.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let denominator = CGFloat(tabs.count)
        return CGSize(width: frame.width / denominator, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}
