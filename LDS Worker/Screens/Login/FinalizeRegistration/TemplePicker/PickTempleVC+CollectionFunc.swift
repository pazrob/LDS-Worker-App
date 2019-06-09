//
//  PickTempleVC+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickTempleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: templeCellId, for: indexPath) as! TempleCell
        cell.templeName.text = " \(filteredTemple[indexPath.item]) Temple"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTemple.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: mainView.templeCollection.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performTempleSelection(with: filteredTemple[indexPath.row])
    }
    
    func performTempleSelection(with chossenTemple: String) {
        
        //Update UI
        mainView.explainerLabel.text = " \(chossenTemple) Temple"
        mainView.searchField.text = chossenTemple
        mainView.templeCollection.isHidden = true
        mainView.templeIcon.tintColor = UIColor.appMainColor
        
        //Nav Button enable
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        //Add selection to Potential User
        potentialUser?.temple = chossenTemple
        
    }
}
