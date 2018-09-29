//
//  PickTempleVC+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickTempleViewController {
    
    func setUpNavBar(){
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.appMainColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
    }
    
    @objc func handleNext(){
        
        let genderPicker = PickGenderController()
        genderPicker.potentialUser = potentialUser
        navigationController?.pushViewController(genderPicker, animated: true)
        
    }
    
}
