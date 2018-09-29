//
//  UIAplication+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/19/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var loginAnimation: UIViewAnimationOptions = .transitionCrossDissolve
    static var logoutAnimation: UIViewAnimationOptions = .transitionCrossDissolve
    
    public static func setRootView(with newViewController: UIViewController,
                                   options: UIViewAnimationOptions = .transitionCrossDissolve,
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
        v.font = v.font.withSize(14)
        v.textAlignment = .center
        v.textColor = UIColor.rgb(red: 0, green: 166, blue: 81)
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
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
    
    static func successAnimation(){
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        window.addSubview(successLabel)
        
        window.addConstrainsWithFormat(format: "H:[v0(150)]", views: successLabel)
        window.addConstrainsWithFormat(format: "V:[v0(30)]", views: successLabel)
        
        successLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        successLabel.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -80).isActive = true
        
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.moveUp(view: self.successLabel)
        }) { _ in
            
            UIView.animate(withDuration: 0.7, delay: 1.5, options: UIViewAnimationOptions.curveEaseOut ,animations: {
                self.moveDown(view: self.successLabel)
                
            }, completion: { _ in
                successLabel.removeFromSuperview()
            })
        }
    }
    
    static func moveUp(view: UIView) {
        view.center.y -= 500
    }
    
    static func moveDown(view: UIView) {
        view.center.y += 500
    }
    
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
