//
//  PhoneNumberView.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class PhoneNumberView: UIView {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "PHONE NUMBER"
        label.font = label.font.withSize(12)
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.backgroundColor = .white
        field.keyboardType = .phonePad
        return field
    }()
    
    
    let divider1: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    let divider5: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    let divider4: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    lazy var deletePhoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(UITextSettings.deletePhone.rawValue, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    func setUpViews() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.appEmptyColor
        addSubview(descriptionLabel)
        
        addSubview(phoneTextField)
        addSubview(divider1)
        
        addSubview(deletePhoneButton)
        addSubview(divider4)
        addSubview(divider5)
        
        addConstrainsWithFormat(format: "H:|-15-[v0]|", views: descriptionLabel)
        addConstrainsWithFormat(format: "V:|-20-[v0(20)]", views: descriptionLabel)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: phoneTextField)
        addConstrainsWithFormat(format: "V:|-45-[v0(50)]", views: phoneTextField)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider1)
        divider1.topAnchor.constraint(equalTo: phoneTextField.topAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: deletePhoneButton)
        addConstrainsWithFormat(format: "V:[v0(50)]", views: deletePhoneButton)
        deletePhoneButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider4)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider4)
        divider4.topAnchor.constraint(equalTo: deletePhoneButton.bottomAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider5)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider5)
        divider5.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

