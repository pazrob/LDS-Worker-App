//
//  GroupRequestCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class GroupRequestScroll: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController : HomeController?
    var groupPosts: [Post]?
    let groupRequestCellId = "groupRequestCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    
    func getPosts() {
        groupPosts = DataService.userGroupPosts
    }
    
    //Scroll Container
    lazy var groupRequestCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appEmptyColor
        cv.dataSource = self
        cv.delegate = self
        cv.register(GroupRequestCell.self, forCellWithReuseIdentifier: groupRequestCellId)
        cv.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        cv.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
        cv.bounces = true
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        getPosts()
        
        if groupPosts?.count != 0 {
            
            addSubview(groupRequestCollection)
            addConstrainsWithFormat(format: "H:|[v0]|", views: groupRequestCollection)
            addConstrainsWithFormat(format: "V:|[v0]|", views: groupRequestCollection)
            
        } else {
            print("You will see cool stuff")
//            addSubview(groupRequestCollection)
//            addConstrainsWithFormat(format: "H:|[v0]|", views: groupRequestCollection)
//            addConstrainsWithFormat(format: "V:|[v0]|", views: groupRequestCollection)
        }
        
        
        
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
            if(indexPath.section == 0){
                header.headerLabel.text = "CURRENT REQUESTS"
            } else {
                header.headerLabel.text = "PAST REQUESTS"
            }
            return header
        } else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! FooterCell
            if(indexPath.section == 0){
                footer.footerLabel.text = "CURRENT will go to PAST based on expiration date"
            } else {
                footer.footerLabel.text = "PAST can be deleted from settings"
            }
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(section == 0){
            return CGSize(width: collectionView.frame.width, height: 20)
        } else {
            return CGSize(width: collectionView.frame.width, height: 80)
        }
    }
    
    //Set number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return groupPosts?.count ?? 0
        } else { return 0 }        
    }
    
    //Set recycler cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: groupRequestCellId, for: indexPath) as! GroupRequestCell
        cell.groupPost = groupPosts?[indexPath.item]
        return cell
    }
    //Set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width,height: 80  )
    }
    //Space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let selectedCell:UICollectionViewCell = groupRequestCollection.cellForItem(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        
        if(indexPath.section == 0){
            if let groupPost = groupPosts?[indexPath.item]{
                homeController?.showGroupRequestDetailController(withRequest: groupPost, isExpired: false)
            }
        }
//        else {
//            if let groupRequest = pastRequests?[indexPath.item]{
//                homeController?.showGroupRequestDetailController(withRequest: groupRequest, isExpired: true)
//            }
//        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cellToDeselect = groupRequestCollection.cellForItem(at: indexPath)
//        cellToDeselect?.contentView.backgroundColor = UIColor.clear
//    }
    
    
}
