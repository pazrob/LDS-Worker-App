//
//  TextField+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UITextField {
    static func getPicker() -> UITextField{
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .right
        field.placeholder = "..."
        return field
    }
}
