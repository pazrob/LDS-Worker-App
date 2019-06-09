////
////  ProfileController+CollectionFunc.swift
////  LDS Worker
////
////  Created by Campus Life Design on 7/6/18.
////  Copyright © 2018 Robinson Paz. All rights reserved.
////
//
//import UIKit
//
//extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    
//    
//    func updateHeaderCell() {
//        
//        let isPhotoEmpty: Bool = (ImageService.userPhoto == nil)
//        
//        //Passing profileController reference
////        cell.profileController = self
//        
//        //Get temple
//        if let temple = FirebaseService.currentUserProfile?.temple {
////            cell.titleProfile.text = "\(temple) \(UITextSettings.worker.rawValue)"
//        }
//        
//        //Get membership date
//        
//        
////        //Update ImageView
////        let name = ImageService.defaultPhotoString
////        cell.imageProfile.image = isPhotoEmpty ? UIImage(named: name) : ImageService.userPhoto
////
////        //Update UI with respect of uploaded picture
////        cell.deletePhotoButton.isHidden = isPhotoEmpty
////        cell.divider2.isHidden = isPhotoEmpty
//    }
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////        if indexPath.section == 0 {
////            let isPhotoEmpty: Bool = ImageService.userPhoto == nil
////            let width = self.profileCollection.bounds.width
////            return  isPhotoEmpty ? CGSize(width: width, height: 235) : CGSize(width: width, height: 285)
////        }
////
////        return CGSize(width: self.profileCollection.frame.width, height: 50)
////    }
//
//
//    
//    
//}
