//
//  Login+RegisterCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginCollectionCell : BaseCell {
    
    weak var loginViewController: LoginViewController?
    
    //Views
    let fieldDivider: UIView = {
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
    let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginForm.emailString.rawValue
        textField.clearButtonMode = .whileEditing
        var leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        leftIcon.image = UIImage(named: "iconName")?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = UIColor.fieldIcon
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
    let forgotLabel = UILabel.getH4(text: LoginForm.forgotPassString.rawValue)
    lazy var signInBtn: UIButton = {
        let button = UIButton.getAppButton(text: LoginForm.signInString.rawValue)
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignInButton(){
        
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        loginViewController?.handleLogin(email: email, password: password)
    }
    
    private func setUpToolBars(){
        //Toolbar for requestDescription
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "Next →", style: .done, target: self, action: #selector(handleNext))
        toolBar.setItems([flexSpace,done], animated: false)
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    @objc func handleNext(){
        passwordField.becomeFirstResponder()
    }
    
    //SetUpViews
    override func setUpViews(){
        super.setUpViews()
        
        addSubview(fieldContainer)
        
        fieldContainer.addSubview(emailField)
        fieldContainer.addSubview(fieldDivider)
        fieldContainer.addSubview(passwordField)
        addSubview(forgotLabel)
        addSubview(signInBtn)
        
        addSubview(signInBtn)
        
        //Constraints
        addConstrainsWithFormat(format: "V:[v0(108)]", views: fieldContainer)
        addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: fieldContainer)
        fieldContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        addConstrainsWithFormat(format: "V:|[v0(54)]", views: emailField)
        addConstrainsWithFormat(format: "H:|[v0]|", views: emailField)
        
        addConstrainsWithFormat(format: "V:[v0(2)]", views: fieldDivider)
        addConstrainsWithFormat(format: "H:|[v0]|", views: fieldDivider)
        addConstraint(NSLayoutConstraint(item: fieldDivider, attribute: .centerY, relatedBy: .equal, toItem: fieldContainer, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "V:[v0(54)]|", views: passwordField)
        addConstrainsWithFormat(format: "H:|[v0]|", views: passwordField)
        
        addConstrainsWithFormat(format: "V:[v0]", views: forgotLabel)
        addConstrainsWithFormat(format: "H:[v0]", views: forgotLabel)
        addConstraint(NSLayoutConstraint(item: forgotLabel, attribute: .top, relatedBy: .equal, toItem: fieldContainer, attribute: .bottom, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: forgotLabel, attribute: .right , relatedBy: .equal, toItem: fieldContainer, attribute: .right, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "V:[v0(42)]", views: signInBtn)
        addConstrainsWithFormat(format: "H:[v0(200)]", views: signInBtn)
        addConstraint(NSLayoutConstraint(item: signInBtn, attribute: .top, relatedBy: .equal, toItem: fieldContainer, attribute: .bottom, multiplier: 1, constant: 40))
        addConstraint(NSLayoutConstraint(item: signInBtn, attribute: .centerX, relatedBy: .equal, toItem: fieldContainer, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Set Up tool bars
        setUpToolBars()
    }
    
}
