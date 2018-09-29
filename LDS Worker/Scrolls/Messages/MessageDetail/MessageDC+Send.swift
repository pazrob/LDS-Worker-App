//
//  MessageDC+Send.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension MessageDetailController {
    
    @objc func handleSend() {
        
        guard let messageText = inputContainerView.textView.text else { return }
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        guard let toUID = partnerUser?.uid else { return }
        
        let messageRef = Database.database().reference().child("messages").childByAutoId()
     
        let timestamp = Int(Date().timeIntervalSince1970)
        let message = [
            "fromId" : myUID,
            "toId" : toUID,
            "text": messageText,
            "timestamp": timestamp
            ] as [String : Any]
        
        //1. Upload all the message to "message" node
        messageRef.updateChildValues(message) { error, databaseRef in
            
            //Get the childByAutoId generated
            let messageID = databaseRef.key
            
            //TODO: Check for erors and make this an atomic operation instead of two users-messages calls, maybe even above here! 3 total
            
            //1. Upload to From
            let userMessagesRef = Database.database().reference()
                .child(BaseNodes.usersLastMessage.rawValue)
                .child(myUID)
                .child(toUID)
            userMessagesRef.setValue(messageID)
            
            //2. Upload to To
            let receipientMessagesRef = Database.database().reference()
                .child(BaseNodes.usersLastMessage.rawValue)
                .child(toUID)
                .child(myUID)
            receipientMessagesRef.setValue(messageID)
            
            
            // <<<<<<<<<
            
            //3. Upload mine
            let userRef = Database.database().reference()
                .child(BaseNodes.userMessages.rawValue)
                .child(myUID)
                .child(toUID)
            userRef.updateChildValues([messageID:1])
//            userRef.updateChildValues([myUID:messageID])
            
            //3. Upload his
            let receipientRef = Database.database().reference()
                .child(BaseNodes.userMessages.rawValue)
                .child(toUID)
                .child(myUID)
            receipientRef.updateChildValues([messageID:1])
        }
        
        
        //Other
        inputContainerView.textView.text = nil
        textViewDidChange(inputContainerView.textView)
    }
    
}
