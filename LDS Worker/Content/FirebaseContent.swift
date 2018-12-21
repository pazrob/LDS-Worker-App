//
//  FirebaseContent.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

enum BaseNodes: String {
    case users = "users"
    case usersTemples = "users-temples"
    case messages = "messages"
    case userMessages = "users-messages"
    case requests = "requests"
    case usersRequest = "users-requests"
    case usersLastMessage = "users-lastMessages"
    case permissions = "isAppBloqued"
}

enum NodeKeys: String {
    case firstName = "firstName"
    case lastName = "lastName"
    case email = "email"
    case photoURL = "photoURL"
    case phone = "phone"
    case temple = "temple"
    case gender = "gender"
    case fromId = "fromId"
    case toId = "toId"
    case text = "text"
    case timestamp = "timestamp"
    case status = "status"
    case uid = "uid"
    case to = "to"
    case from = "from"
    case note = "note"
    case lastMessage = "lastMessage"
}

enum StorageKeys: String {
    case user = "user"
}
