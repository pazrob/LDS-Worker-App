//
//  GroupRequestCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class MyRequestScroll: BaseCell {
    
    var homeController : HomeController?
    let myRequestCellId = "myRequestCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    var myPosts: [Post]?
    
    //Loads the array of Videos
    func getPosts(){
        myPosts = DataService.userPersonalPosts
    }
    
    //Scroll Container
    lazy var myrequestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appEmptyColor
        cv.dataSource = self
        cv.delegate = self
        cv.register(MyRequestCell.self, forCellWithReuseIdentifier: myRequestCellId)
        cv.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        cv.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        getPosts()
        addDataListener()
        
        addSubview(myrequestCollectionView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: myrequestCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: myrequestCollectionView)
    }
    
    private func addDataListener() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(DataService.self, selector: #selector(self.handleDataChange), name: nil, object: DataService.userPersonalPosts)
    }
    
    @objc func handleDataChange() {
        print("There has been a change in the data!")
    }
    
}



extension MyRequestScroll: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //Set number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return myPosts?.count ?? 0
        } else {
            return myPosts?.count ?? 0
        }
    }
    //Set recycler cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myRequestCellId, for: indexPath) as! MyRequestCell
        cell.myPost = (indexPath.section == 0) ? myPosts?[indexPath.item] : myPosts?[indexPath.item]
        return cell
    }
    //Set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width,height: 110)
    }
    //Space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            if let theRequest = myPosts?[indexPath.item]{
                homeController?.showMyRequestDetailController(withRequest: theRequest, isExpired: false)
            }
        } else {
            //            if let theRequest = pastRequests?[indexPath.item]{
            ////                homeController?.showMyRequestDetailController(withRequest: theRequest, isExpired: true)
            //            }
        }
        
        
    }
}


extension MyRequestScroll {
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
    
}



