//
//  PhoneNumberController.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/14/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class PhoneNumberController: UIViewController {
    
    var modalMode: Bool?
    
    lazy var mainView: PhoneNumberView = {
        let mv = PhoneNumberView()
        mv.phoneTextField.delegate = self
        mv.deletePhoneButton.addTarget(self, action: #selector(handleDeletePhone), for: .touchUpInside)
        mv.phoneTextField.becomeFirstResponder()
        return mv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        setUpViews()
        updateViewBaseOnPhone()
        
        setUpInfo()
    }
    
    
    func setUpViews() {
        view.addSubview(mainView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: mainView)
    }
    
    
    func updateViewBaseOnPhone() {
        
        //Check if there is phone
        if FirebaseService.currentUserProfile?.phone == nil {
            mainView.deletePhoneButton.isHidden = true
            mainView.divider4.isHidden = true
        } else {
            //If there is no phone
            mainView.deletePhoneButton.isHidden = false
            mainView.divider4.isHidden = false
        }
    }
    
    
    // Checks if there current user has a phone and displays it
    func setUpInfo() {
        
        guard let userPhone = FirebaseService.currentUserProfile?.phone else { return }
        
        let phoneString = String.getNumberedFormated(phone: userPhone)
        mainView.phoneTextField.text = phoneString
    }
    
}

