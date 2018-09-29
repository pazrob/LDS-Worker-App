//
//  MessageDC+DataRequest.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/13/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension MessageDetailController {
    
    func fetchNavBarInfo() {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let chatPartnerId = partnerId else { return }
        
        let recipientRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple).child(chatPartnerId)
        recipientRef.observeSingleEvent(of: DataEventType.value, with: { userSnap in
            
            if let dictionary = userSnap.value as? [String:Any],
                let firstName = dictionary[NodeKeys.firstName.rawValue] as? String,
                let lastName = dictionary[NodeKeys.lastName.rawValue] as? String,
                let gender = dictionary[NodeKeys.gender.rawValue] as? String{
                
                let photoUrl = dictionary[NodeKeys.photoURL.rawValue] as? String
                let phone = dictionary[NodeKeys.phone.rawValue] as? String
                
                //User model is available now
                self.partnerUser = UserModel(photoURL: photoUrl, firstName: firstName, lastName: lastName,
                                             uid: userSnap.key, gender: gender, phone: phone)
                
                //Set up navigation bar now
                self.setUpNavigationBar()
            }
            
        }, withCancel: { err in
            print("User could not be loaded.")
        })
    }
    
    func fetchConversation() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let partnerUid = partnerId else { return }
        
        //Observe messageId added on root -> user-messages -> myId -> partnerId
        let userMessageRef = Database.database().reference()
            .child(BaseNodes.userMessages.rawValue)
            .child(uid)
            .child(partnerUid)
        userMessageRef.observe( .childAdded) { snapshot in
            
            print(snapshot)
            
            let messageId = snapshot.key
            
            //Fetch message
            MessageService.fetchSingleMessage(with: messageId, completion: { messageModel in
                
                //If fails
                guard let message = messageModel else { return }
                
                //If success
                self.messages.append(message)
                
                //This is called many times
                self.attempToReloadCollection()
            })
            
        }
    }
    
    func attempToReloadCollection() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadCollection), userInfo: nil, repeats: false)
    }
    
    @objc func handleReloadCollection() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.collectionView?.scrollToLast(withAnimation: false)
            
        }
    }
    
}
