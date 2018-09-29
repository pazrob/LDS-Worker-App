//
//  MessageScroll+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MessageScroll {
    
    func addMessageObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.getTheArray), name: NSNotification.Name.messagesKey, object: nil)
    }
    
    @objc func getTheArray(notification: Notification) {
        if let messages = notification.userInfo?["messages"] as? [MessageModel] {
            self.messages = messages
            messagesCollectionView.reloadData()
        }
    }    
    
}
