//
//  MyRequestScroll+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestScroll: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        
        addSubview(myrequestCollectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: myrequestCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: myrequestCollectionView)        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPosts.isEmpty ? 1 : myPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if myPosts.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath) as! EmptyCollectionCell
            cell.imageView.image = UIImage(named: "myBackground")
            cell.textView.text = EmptyStateCase.subTitle.rawValue
            cell.label.text = EmptyStateCase.mainTitle.rawValue
            cell.button.isUserInteractionEnabled = true
            cell.isUserInteractionEnabled = true
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myRequestCellId, for: indexPath) as! MyRequestCell
        cell.myPost = myPosts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if myPosts.isEmpty {
            return CGSize(width: myrequestCollectionView.frame.width,height: myrequestCollectionView.frame.height - 200)
        }
        return CGSize(width: frame.width,height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if myPosts.isEmpty {
            return
        }
        
        let theRequest = myPosts[indexPath.item]
        homeController?.showMyRequestDetailController(withRequest: theRequest)
        
    }
}

extension MyRequestScroll {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell        
        if myPosts.isEmpty {
            header.headerLabel.text = ""
        } else {
            header.headerLabel.text = "MY REQUESTS"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    
}
