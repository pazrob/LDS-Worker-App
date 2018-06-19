//
//  Application+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension UIApplication {
    
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
