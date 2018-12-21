//
//  Login+RegisterCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.

import Foundation
import UIKit


class RegisterCollectionCell : BaseCell {
    
    var loginViewController: LoginViewController?
    let genderOptions = [LoginForm.male.rawValue, LoginForm.female.rawValue]
    
    //Views
    let fieldDivider: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.appEmptyColor
        return myView
    }()
    let fieldDivider2: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.appEmptyColor
        return myView
    }()
    let fieldDivider3: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.appEmptyColor
        return myView
    }()
    let fieldDivider4: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.appEmptyColor
        return myView
    }()
    let fieldContainer: UIView = {
        let myView = UIView()
        myView.backgroundColor = .white
        myView.layer.cornerRadius = 10
        return myView
    }()
    let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginForm.firstNameString.rawValue
        var leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        leftIcon.image = UIImage(named: "iconName")?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = .fieldIcon
        leftIcon.contentMode = .scaleAspectFit
        textField.leftView = leftIcon
        textField.leftViewMode = UITextField.ViewMode.always
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    let lastnameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginForm.lastNameString.rawValue
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginForm.emailString.rawValue
        textField.clearButtonMode = .whileEditing
        var leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        leftIcon.image = UIImage(named: "iconEmail")?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = .fieldIcon
        leftIcon.contentMode = .scaleAspectFit
        textField.leftView = leftIcon
        textField.leftViewMode = UITextField.ViewMode.always
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginForm.passwordString.rawValue
        textField.clearButtonMode = .whileEditing
        var leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        leftIcon.image = UIImage(named: "iconLock")?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = .fieldIcon
        leftIcon.contentMode = .scaleAspectFit
        textField.leftView = leftIcon
        textField.leftViewMode = UITextField.ViewMode.always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registerBtn: UIButton = {
        
        let button = UIButton.getAppButton(text: LoginForm.registerString.rawValue)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    
    
    let agreementParagraph = UITextView.getAgreement()
    
    //SetUpViews
    override func setUpViews(){
        super.setUpViews()
        
        addSubview(fieldContainer)
        
        fieldContainer.addSubview(nameField)
        fieldContainer.addSubview(fieldDivider4)
        fieldContainer.addSubview(lastnameField)
        fieldContainer.addSubview(fieldDivider)
        fieldContainer.addSubview(emailField)
        fieldContainer.addSubview(fieldDivider2)
        fieldContainer.addSubview(passwordField)
        
        addSubview(registerBtn)
        addSubview(agreementParagraph)
        
        //Constraints
        addConstrainsWithFormat(format: "V:[v0(162)]", views: fieldContainer)
        addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: fieldContainer)
        fieldContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        addConstrainsWithFormat(format: "V:|[v0(54)]", views: nameField)
        let width = Int(self.bounds.width / 2) - 20
        print(width)
        addConstrainsWithFormat(format: "H:|[v0(\(width))]-10-[v1]|", views: nameField, lastnameField)
        addConstrainsWithFormat(format: "V:|[v0(54)]", views: lastnameField)
        
        addConstrainsWithFormat(format: "V:[v0(54)]", views: fieldDivider4)
        addConstrainsWithFormat(format: "H:[v0(2)]", views: fieldDivider4)
        addConstraint(NSLayoutConstraint(item: fieldDivider4, attribute: .right, relatedBy: .equal, toItem: nameField, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: fieldDivider4, attribute: .centerY, relatedBy: .equal, toItem: nameField, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        addConstrainsWithFormat(format: "V:[v0(2)]", views: fieldDivider)
        addConstrainsWithFormat(format: "H:|[v0]|", views: fieldDivider)
        addConstraint(NSLayoutConstraint(item: fieldDivider, attribute: .top, relatedBy: .equal, toItem: nameField, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "V:[v0(54)]", views: emailField)
        addConstrainsWithFormat(format: "H:|[v0]|", views: emailField)
        addConstraint(NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .equal, toItem: nameField, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "V:[v0(2)]", views: fieldDivider2)
        addConstrainsWithFormat(format: "H:|[v0]|", views: fieldDivider2)
        addConstraint(NSLayoutConstraint(item: fieldDivider2, attribute: .top, relatedBy: .equal, toItem: emailField, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "V:[v0(54)]", views: passwordField)
        addConstrainsWithFormat(format: "H:|[v0]|", views: passwordField)
        addConstraint(NSLayoutConstraint(item: passwordField, attribute: .top, relatedBy: .equal, toItem: emailField, attribute: .bottom, multiplier: 1, constant: 0))        
                
        addConstrainsWithFormat(format: "V:[v0(42)]", views: registerBtn)
        addConstrainsWithFormat(format: "H:[v0(200)]", views: registerBtn)
        registerBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40).isActive = true
        registerBtn.centerXAnchor.constraint(equalTo: fieldContainer.centerXAnchor).isActive = true
        
        addConstrainsWithFormat(format: "V:[v0(50)]", views: agreementParagraph)
        addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: agreementParagraph)
        agreementParagraph.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 20).isActive = true
        agreementParagraph.centerXAnchor.constraint(equalTo: fieldContainer.centerXAnchor).isActive = true
        
    }
    
    @objc func handleRegister(){
        
        //Check form to be filled
        if !isFormFilled() {
            UIAlertController.sendMessage(viewController: loginViewController, message: "Please fill all boxes")
            return
        }
        
        //Get values
        guard let firstName = nameField.text else { return }
        guard let lastName = lastnameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        let potentialUser = UserRegistrationModel(firstName: firstName, lastName: lastName, email: email,
                                                  password: password, temple: nil, gender: nil)
        
        //Allow LoginController to handle Registration
        loginViewController?.handleRegister(potentialUser: potentialUser)
    }
    
    func isFormFilled() -> Bool {
        if nameField.text!.isEmpty || lastnameField.text!.isEmpty ||
            emailField.text!.isEmpty || passwordField.text!.isEmpty {
            return false
        }
        return true
    }
    
}
