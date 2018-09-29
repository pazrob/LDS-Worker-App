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
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var temple: String
    var imageURL: String?
    var phone: String?
    
    init(uid: String, firstName: String, lastName: String, email: String, gender: String, imageURL: String?, temple: String, phone: String?) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.imageURL = imageURL
        self.temple = temple
        self.phone = phone
    }
}
