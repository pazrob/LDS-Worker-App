//
//  File.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/28/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class MessageService {
    
    static var messageDictionary = [String:MessageModel]()
    static var timer: Timer?
    
    //For Scroll Messages
    static func loadMessages() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        //Fetch node partner-conversation and observe .childAdded
        let userMessagesRef = Database.database().reference().child(BaseNodes.usersLastMessage.rawValue).child(uid)
        userMessagesRef.observe( .childAdded, with: { partnerSnap in
            
            let partnerId = partnerSnap.key
            
            //Observe .value on partnerSnap node
            let userMessagesRef2 = Database.database().reference()
                .child(BaseNodes.usersLastMessage.rawValue)
                .child(uid)
                .child(partnerId)
            
            userMessagesRef2.observe( .value, with: { messageIdSnap in
                
                //Fetch message from lastMessageId
                if let lastMessageId = messageIdSnap.value as? String {
                    fetchSingleMessage(with: lastMessageId, completion: { messageModel in
                        filterAndSendNotification(messageIn: messageModel)
                    })
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    //For Scroll
    static func filterAndSendNotification(messageIn: MessageModel?) {
        
        guard let message = messageIn else { return }
        
        //Filter Messages
        if let chatPartnerId = message.getChatReceipientUID() {
            self.messageDictionary[chatPartnerId] = message
        }
        
        //Send attemp to Send Notification to reload the table
        self.attempTosendNotification()
    }
    
    //For Scroll Messages and Detail
    static func fetchSingleMessage(with messageId: String, completion: @escaping (_ image: MessageModel?) -> ()){
        
        var message: MessageModel?
        
        //Fetch message snap (one time) from messageId
        let messageRef = Database.database().reference().child(BaseNodes.messages.rawValue).child(messageId)
        messageRef.observeSingleEvent(of: .value, with: { messageSnap in
            
            print(messageSnap)//delete
            
            if let dictionary = messageSnap.value as? [String: Any] {
                
                //Parse dictionary to Message-Model
                message = MessageModel(dictionary: dictionary)
            }
            
            //Message if success, nil if fails
            completion(message)
            
        }, withCancel: nil)
    }
    
    //Allows only the last loop to send the notification
    static func attempTosendNotification() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.sendNotification), userInfo: nil, repeats: false)
    }
    
    //Send the final loaded array in a notification
    @objc static func sendNotification() {
        
        var theMessages = [MessageModel]()
        
        ///Get the array from dictionary
        theMessages = Array(self.messageDictionary.values)
        
        //Sort array with timestamps
        theMessages.sort(by: { message1, message2 -> Bool in
            guard let timestamp1 = message1.timestamp else { return false }
            guard let timestamp2 = message2.timestamp else { return false }
            
            return (timestamp1.int32Value) > (timestamp2.int32Value)
        })
        
        //Post notification with a dictionary
        let arrayData : [String: [MessageModel]] = [BaseNodes.messages.rawValue : theMessages]
        NotificationCenter.default.post(name: NSNotification.Name.messagesKey, object: nil, userInfo: arrayData)
    }
    
}
