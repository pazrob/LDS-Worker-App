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
    
    static func startActivityLoad(view: UIView) {
        
        //Loading View
        view.addSubview(backgroundView)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: backgroundView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: backgroundView)
        backgroundView.isHidden = false
        
        //Loading activity indicator
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
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
