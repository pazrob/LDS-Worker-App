//
//  ProfileController+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension ProfileController {
    
    func setUpNavigationBar(){
        
        self.title = UITextSettings.profile.rawValue
        navigationItem.largeTitleDisplayMode = .never
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(handleSave))        
        
    }
    
}
