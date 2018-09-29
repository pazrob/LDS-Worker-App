//
//  UserRegistrationModel.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/26/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class UserRegistrationModel {
    
    var firstName: String
    var lastName: String
    var gender: String?
    var email: String
    var password: String
    var temple: String?
    
    
    init(firstName: String, lastName: String, email: String, password: String, temple: String?, gender: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        
        self.temple = temple
        self.gender = gender
    }
    
    
    
}
