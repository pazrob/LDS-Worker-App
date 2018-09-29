//
//  NotificationCenter+Extensions.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/19/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let personalRequestKey = Notification.Name("com.LDSWorker.personalRequestKey")
    static let groupRequestKey = Notification.Name("com.LDSWorker.groupRequestKey")
    static let messagesKey = Notification.Name("com.LDSWorker.messagesKey")
}
