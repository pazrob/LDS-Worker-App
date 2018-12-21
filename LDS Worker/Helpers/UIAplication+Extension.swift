//
//  UIAplication+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/19/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var loginAnimation: UIView.AnimationOptions = .transitionCrossDissolve
    static var logoutAnimation: UIView.AnimationOptions = .transitionCrossDissolve
    
    public static func setRootView(with newViewController: UIViewController,
                                   options: UIView.AnimationOptions = .transitionCrossDissolve,
                                   animated: Bool = true,
                                   duration: TimeInterval = 0.5,
                                   completion: (() -> Void)? = nil) {
        guard animated else {
            UIApplication.shared.keyWindow?.rootViewController = newViewController
            return
        }
        
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {
            
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = newViewController
            UIView.setAnimationsEnabled(oldState)
            
        }) { _ in
            completion?()
        }

    }
    
    static let successLabel: UILabel = {
        let v = UILabel()
        v.text = "Success ✔︎"
        v.font = v.font.withSize(15)
        v.textAlignment = .center
        v.textColor = UIColor.rgb(red: 0, green: 166, blue: 81)
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 18
        v.addShadow()
        v.layer.masksToBounds = true
        v.layer.borderColor = UIColor.rgb(red: 0, green: 166, blue: 81).cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    static let noConnection: UILabel = {
        let v = UILabel()
        v.text = "No internet connection"
        v.textAlignment = .center
        v.textColor = UIColor.white
        v.backgroundColor = UIColor.red
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addShadow()
        return v
    }()
    
    static func moveUp(view: UIView) {
        view.center.y -= 500
    }
    
    static func moveDown(view: UIView) {
        view.center.y += 500
    }
    
}
