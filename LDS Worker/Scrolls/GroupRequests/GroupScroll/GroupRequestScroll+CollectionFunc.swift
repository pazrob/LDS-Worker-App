//
//  GroupRequestScroll+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension GroupRequestScroll {
    
    func setUpCollectionView() {
        
        addSubview(groupRequestCollection)
        addConstrainsWithFormat(format: "H:|[v0]|", views: groupRequestCollection)
        addConstrainsWithFormat(format: "V:|[v0]|", views: groupRequestCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupPosts.isEmpty ? 1 : groupPosts[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupPosts.isEmpty ? 1 : groupPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Return Empty Collection
        if groupPosts.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath) as! EmptyCollectionCell
            cell.imageView.image = UIImage(named: "groupBackground")
            cell.textView.text = EmptyStateCase.mainTitle.rawValue
            cell.label.text = EmptyStateCase.subTitle.rawValue
            cell.button.setTitle(EmptyStateCase.buttonText.rawValue, for: .normal)
            cell.button.addTarget(self, action: #selector(selectLabel), for: .touchUpInside)
            cell.button.isUserInteractionEnabled = true
            cell.isUserInteractionEnabled = true
            return cell
        }
        
        //Return GroupRequestCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: groupRequestCellId, for: indexPath) as! GroupRequestCell
        setUpCell(cell, post: groupPosts[indexPath.section][indexPath.item])
        return cell
    }
    
    func setUpCell(_ cell: GroupRequestCell, post: Post) {
        
        //Name
        cell.nameTitle.text = "\(post.getGenderTitle()) \(post.lastName), \(post.firstName)"
        
        //Date
        cell.specifics.text = " \(Date.getStringTime(with: post.from)) - \(post.to)"
        
        //Asign Default picture based on gender
        if post.gender == "m" {
            cell.userProfileImageView.image = UIImage(named: PictureKeys.brotherDefault.rawValue)
            cell.genderDot.backgroundColor = UIColor.brotherColor
        } else {
            cell.userProfileImageView.image = UIImage(named: PictureKeys.sisterDefault.rawValue)
            cell.genderDot.backgroundColor = UIColor.sisterColor
        }
        
        //Status
        if post.status {
            cell.status.text = AppContent.statusPositive.rawValue
            cell.status.textColor = UIColor.appMainColor
            
        } else {
            cell.status.text = AppContent.statusNegative.rawValue
            cell.status.textColor = UIColor.appUncovered
        }
        
        //Photo
        if let URLString = post.imageURL {
            
            if let imageURL = URL(string: URLString) {
                ImageService.getImage(withURL: imageURL) { profilePic in
                    
                    //If no picture was fetched
                    if profilePic == nil {
                        cell.userProfileImageView.image = UIImage(named: post.getGenderPhotoString())
                        return
                    }
                    
                    //If success
                    cell.userProfileImageView.image = profilePic
                }
            }
        } else {
            //If no url was found
            cell.userProfileImageView.image = UIImage(named: post.getGenderPhotoString())
        }
    }
    
    @objc func selectLabel() {
        
        let activityVC = UIActivityViewController(activityItems: ["I am using this LDS Worker app, here it is the link to download it! \n www.ldsworker.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = homeController?.view
        
        self.homeController?.present(activityVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if groupPosts.isEmpty {
            return CGSize(width: groupRequestCollection.frame.width,height: groupRequestCollection.frame.height - 200)
        }
        return CGSize(width: groupRequestCollection.frame.width,height: 80  )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if groupPosts.isEmpty { return }
        
        let groupPost = groupPosts[indexPath.section][indexPath.item]
        homeController?.showGroupRequestDetailController(withRequest: groupPost, isExpired: false)
    }
}

extension GroupRequestScroll {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        if groupPosts.isEmpty {
            header.headerLabel.text = ""
        } else {
            header.headerLabel.text = Date.getStringDate(with: groupTitles[indexPath.section])
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
