//
//  SettingsController+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension SettingsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        view.addSubview(settingCollection)
        
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: settingCollection)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: settingCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        header.headerLabel.text = settingTitles[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingContent[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Botom signature
        if indexPath.section == 5 {
            let signatureCell = settingCollection.dequeueReusableCell(withReuseIdentifier: signatureCellId, for: indexPath) as! SignatureCell
            return signatureCell
        }
        
        let cell = settingCollection.dequeueReusableCell(withReuseIdentifier: defaultCellId, for: indexPath) as! SettingCell
        cell.cellLabel.text = settingContent[indexPath.section][indexPath.item]
        
        //Receive Notification
        if settingTitles[indexPath.section] == UITextSettings.preferences.rawValue {
            cell.detailArrow.isHidden = true
            cell.cellSwitch.isHidden = false
            
            let notificationOn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.notificationOn.rawValue)
            if notificationOn {
                cell.cellSwitch.isOn = true
            }
        } else {
            //All rest cells
            cell.cellSwitch.isHidden = true
            cell.detailArrow.isHidden = false
            
        }
        
        if indexPath == [4,1] {
            cell.cellLabel.textColor = UIColor.rgb(red: 124, green: 10, blue: 2)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 5 {
            return CGSize(width: self.view.frame.width, height: 250)
        }
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 1 {
            print("Ignoring PREFERENCES section")
            return
        }
        openSelection(atIndexPath: indexPath)
    }
    
    
    
}
