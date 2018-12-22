//
//  HomeController+NavBarExtension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/26/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

//Set up setting and contacts navigation bar btns.

extension HomeController {
    
    
    func setUpNavigationBarItems(){
        
        title = "Temple Worker"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.appMainColor
        
        //Left Setting Button
        let settingButton = UIButton(type: .system)
        settingButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        settingButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let settingIcon = UIImage(named: PictureKeys.settingsIcon.rawValue)
        settingButton.setImage(settingIcon, for: .normal)
        settingButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        settingButton.imageView?.contentMode = .scaleAspectFit
        settingButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingButton)
        
        //Right Setting Button
        let contactButton = UIButton(type: .system)
        contactButton.addTarget(self, action: #selector(handleContactsButton), for: .touchUpInside)
        contactButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let contactIcon = UIImage(named: PictureKeys.contactsIcon.rawValue)
        contactButton.setImage(contactIcon, for: .normal)
        contactButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        contactButton.imageView?.contentMode = .scaleAspectFit
        contactButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        contactButton.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contactButton)
        
        //Back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: .none)
    }

    //Handle Settings button
    @objc func handleSettingsButton(){
        let settingController = SettingsController()
        settingController.homeController = self
        let settingNavigation = UINavigationController(rootViewController: settingController)
        self.present(settingNavigation, animated: true, completion: nil)
    }
    
    //Handle Contacts button
    @objc func handleContactsButton(){
        let layout = UICollectionViewFlowLayout()
        let contactsController = ContactsController(collectionViewLayout: layout)
        contactsController.homeControllerRef = self
        let contactsNavigation = UINavigationController(rootViewController: contactsController)
        contactsNavigation.modalPresentationStyle = .overCurrentContext
        self.present(contactsNavigation, animated: true, completion: nil)
    }
    
}
