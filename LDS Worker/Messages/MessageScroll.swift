//
//  GroupRequestCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class MessageScroll: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController : HomeController?
    var messages: [MessageModel]?
    let myRequestCellId = "myRequestCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    

    func fetchMessages(){
        
        messages = {
            let messageA =  MessageModel()
            messageA.senderName = "Peter Carliston"
            messageA.senderPicture = "pro3"
            messageA.message = "Thanks again, I will coordinate and make sure"
            messageA.date = "now"
            
            let messageB =  MessageModel()
            messageB.senderName = "Tom Cruise"
            messageB.senderPicture = "pro5"
            messageB.message = "Clear as mood haha if you know."
            messageB.date = "2:00 pm"
            
            let messageC =  MessageModel()
            messageC.senderName = "Brian Smith"
            messageC.senderPicture = "pro5"
            messageC.message = "And then I tried to worn her but there were to ma"
            messageC.date = "1:01 pm"
            
            let messageD =  MessageModel()
            messageD.senderName = "Richard Fernelious"
            messageD.senderPicture = "pro"
            messageD.message = "There is a time where you and I could meet "
            messageD.date = "5:00 am"
            return [messageA, messageB, messageC, messageD, messageB, messageC, messageD, messageB, messageC, messageD, messageB, messageC, messageD]
        }()
        
       
    }
    
    //Scroll Container
    lazy var myrequestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appEmptyColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        fetchMessages()
        addSubview(myrequestCollectionView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: myrequestCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: myrequestCollectionView)
        
        //Using GroupRequesrVideoCell
        myrequestCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: myRequestCellId)
        myrequestCollectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        myrequestCollectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
            header.headerLabel.text = "MESSAGES"
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! FooterCell
            footer.footerLabel.text = "Messages can be deleted"
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    
    //Set number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return messages?.count ?? 0
    }
    //Set recycler cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myRequestCellId, for: indexPath) as! MessageCell
        cell.theMessage = messages?[indexPath.item]
        return cell
    }
    //Set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width,height: 80)
    }
    //Space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
//        if let theRequest = messages?[indexPath.item]{
//            homeController?.showMyRequestDetailController(withRequest: theRequest, isExpired: false)
//        }
    }
}
