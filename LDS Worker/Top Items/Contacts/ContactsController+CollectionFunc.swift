//
//  ContactsController+TableFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension ContactsController: UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        
        collectionView?.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.alwaysBounceVertical = true
        //Make button clickable feel
        
        collectionView?.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        collectionView?.backgroundView = blurEffectView
        
        collectionView?.register(ContactCell.self, forCellWithReuseIdentifier: tableViewId)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedWorkers[section].value.count
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sortedWorkers.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tableViewId, for: indexPath) as! ContactCell
        updateCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    //Updates cell
    func updateCell(cell: ContactCell, indexPath: IndexPath) {
        
        //Get user object
        let atUser = sortedWorkers[indexPath.section].value[indexPath.item]
        
        //Update Name
        cell.fullNameLabel.text = atUser.fullName
        
        //Update View base in phone
        if let  phone = atUser.phone {
            cell.cellPhoneNumber = phone
            
            cell.phoneNumber.text = String.getNumberedFormated(phone: phone)
            
            cell.callButton.backgroundColor = UIColor.appMainColor
            cell.callButton.alpha = 1
            cell.callButton.isEnabled = true
            
            cell.messageButton.backgroundColor = UIColor.appMainColor
            cell.messageButton.alpha = 1
            cell.messageButton.isEnabled = true
            
        } else {
            cell.cellPhoneNumber = nil
            
            cell.phoneNumber.text = ""
            
            cell.callButton.backgroundColor = UIColor.lightGray
            cell.callButton.alpha = 0.3
            cell.callButton.isEnabled = false
            
            cell.messageButton.backgroundColor = UIColor.lightGray
            cell.messageButton.alpha = 0.3
            cell.messageButton.isEnabled = false
        }
        
        //Asign Default picture based on gender
        if atUser.gender == "m" {
            cell.userPhoto.image = UIImage(named: PictureKeys.brotherDefault.rawValue)
            cell.genderDot.backgroundColor = UIColor.brotherColor
        } else {
            cell.userPhoto.image = UIImage(named: PictureKeys.sisterDefault.rawValue)
            cell.genderDot.backgroundColor = UIColor.sisterColor
        }

        //Photo
        if let URLString = atUser.photoURL {
            
            if let imageURL = URL(string: URLString) {
                ImageService.getImage(withURL: imageURL) { profilePic in
                    
                    //If no picture was fetched
                    if profilePic == nil {
                        cell.userPhoto.image = (atUser.gender == "m") ?
                            UIImage(named: PictureKeys.brotherDefault.rawValue) :
                            UIImage(named: PictureKeys.sisterDefault.rawValue)
                        return
                    }
                    
                    //If success
                    cell.userPhoto.image = profilePic
                }
            }
        } else {
            //If no url was found
            cell.userPhoto.image = (atUser.gender == "m") ?
                UIImage(named: PictureKeys.brotherDefault.rawValue) :
                UIImage(named: PictureKeys.sisterDefault.rawValue)
        }
        
        //Give controller reference
        cell.contactsController = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
}

extension ContactsController {
    
    //Header dequeue
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
            
            let char = sortedWorkers[indexPath.section].key
            header.headerLabel.text = "\(char)"
            header.headerLabel.font = header.headerLabel.font.withSize(14)
            return header
    }
    
    
    //Header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
