//
//  SettingsController+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
 
extension SettingsController {
    
    func setUpNavigationBar() {
        
        self.navigationController?.view.backgroundColor = UIColor.appEmptyColor
        
        title = UITextSettings.settings.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.appMainColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: UITextSettings.done.rawValue, style: .done, target: self, action: #selector(handleDone))
    }
    
    @objc func handleDone(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
