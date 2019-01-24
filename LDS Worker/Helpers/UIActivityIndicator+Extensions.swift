//
//  UIActivityIndicator.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    static var activityIndicator = UIActivityIndicatorView()
    
    static let backgroundView: UIView = {
        let wView = UIView()
        wView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        wView.translatesAutoresizingMaskIntoConstraints = false
        return wView
    }()
    
    static func startActivityLoad() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        //Loading View
        window.addSubview(backgroundView)
        window.addConstrainsWithFormat(format: "H:|[v0]|", views: backgroundView)
        window.addConstrainsWithFormat(format: "V:|[v0]|", views: backgroundView)
        backgroundView.isHidden = false
        
        //Loading activity indicator
        activityIndicator.center = window.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        window.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //Block all phone interactions
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func stopActivityLoad() {
        backgroundView.isHidden = true
        activityIndicator.stopAnimating()
        
        //Remove the view
        backgroundView.removeFromSuperview()
        
        //Restore all phone interactions
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
