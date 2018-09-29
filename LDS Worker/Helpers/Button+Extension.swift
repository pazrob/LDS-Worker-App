//
//  Button+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension UIButton {
    
    static func getAppButton(text: String) -> UIButton{
        let cb = UIButton(type: .system)
        cb.backgroundColor = UIColor.appMainColor
        cb.setTitle(text, for: .normal)
        cb.setTitleColor(UIColor.white, for: .normal)
        cb.titleLabel?.textAlignment = .center
        cb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cb.titleLabel?.textColor = .white
        cb.layer.cornerRadius = 21
        cb.isUserInteractionEnabled = true
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }
    
    static func getAppGhostButton(text: String) -> UIButton{
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.clear
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.cornerRadius = 21
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
