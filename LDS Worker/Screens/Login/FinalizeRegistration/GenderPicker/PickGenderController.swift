//
//  PickTempleController.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class PickGenderController: UIViewController {
    
    let genderOptions = ["Select Gender", "Brother", "Sister"]
    var potentialUser: UserRegistrationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpNavBar()
    }
    
    let explainerLabel: UILabel = {
        let label = UILabel()
        label.text = "I am a"
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var genderPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        return pickerView
    }()
    
    
    func setUpViews() {
        
        view.backgroundColor = UIColor.appEmptyColor
        view.addSubview(explainerLabel)
        view.addSubview(genderPicker)
        
        view.addConstrainsWithFormat(format: "V:[v0]", views: explainerLabel)
        view.addConstrainsWithFormat(format: "H:[v0]", views: explainerLabel)
        explainerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        explainerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: genderPicker)
        genderPicker.topAnchor.constraint(equalTo: explainerLabel.bottomAnchor, constant: -20).isActive = true
    }
    
}
