//
//  UserShared.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/11/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit

class UserProfile {
    var uid: String?
    var email: String?
    var firstName: String?
    var lastName: String?    
    var imageURL: String?
    var temple: String?
    
    
    init(uid: String?, firstName: String?, lastName: String?, email: String?, imageURL: String?) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = imageURL
    }
    
    init(uid: String?, firstName: String?, lastName: String?, email: String?, imageURL: String?, temple: String?) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = imageURL
        self.temple = temple
    }
}
