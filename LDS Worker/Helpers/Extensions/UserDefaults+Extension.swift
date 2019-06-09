//
//  UserDefaults+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/11/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    static func setLoggedInUserDefault() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
}
