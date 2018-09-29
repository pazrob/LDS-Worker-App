//
//  LoginViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController{
        
    let loginCellId = "loginCellId"
    let registerCellId = "registerCellId"
    var isFirstCellActive: Bool?
    var iconBottomAnchor : NSLayoutConstraint?
    var collectionBottomConstraint : NSLayoutConstraint?
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObservers()
        setUpNavigationBar()
        setUpViews()
        setUpCollectionView()
    }
    
    let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var loginCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delaysContentTouches = false
        cv.backgroundColor = .clear
        cv.keyboardDismissMode = .interactive
        cv.register(LoginCollectionCell.self, forCellWithReuseIdentifier: loginCellId)
        cv.register(RegisterCollectionCell.self, forCellWithReuseIdentifier: registerCellId)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = LoginForm.goPreviousView.rawValue
        label.textColor = UIColor.appPeach
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleLoginSwipe))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = LoginForm.goNextView.rawValue
        label.textColor = UIColor.appPeach
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleRegisterSwipe))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    var collectionTopConstraint: NSLayoutConstraint?
    var iconWidthAnchor: NSLayoutConstraint?
    var iconHeightAnchor: NSLayoutConstraint?
    var iconCenterAnchor: NSLayoutConstraint?
    var iconLeftAnchor: NSLayoutConstraint?
    
    private func setUpViews(){
        
        view.backgroundColor = UIColor.appEmptyColor
        loginLabel.isHidden = true
        view.addSubview(appIcon)
        view.addSubview(loginCollection)
        view.addSubview(registerLabel)
        view.addSubview(loginLabel)
        
        //Icon Constraints
        iconWidthAnchor = appIcon.widthAnchor.constraint(equalToConstant: 130)
        iconWidthAnchor?.isActive = true
        iconHeightAnchor = appIcon.heightAnchor.constraint(equalToConstant: 130)
        iconHeightAnchor?.isActive = true
        iconBottomAnchor = appIcon.bottomAnchor.constraint(equalTo: loginCollection.topAnchor, constant: 0)
        iconBottomAnchor?.isActive = true
        iconCenterAnchor = appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        iconCenterAnchor?.isActive = true
        iconLeftAnchor = appIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        iconLeftAnchor?.isActive = false
        
        //Constraints for the collection
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: loginCollection)
        collectionTopConstraint = loginCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        collectionTopConstraint?.isActive = true
        collectionBottomConstraint = loginCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        collectionBottomConstraint?.isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(40)]-30-|", views: registerLabel)
        view.addConstrainsWithFormat(format: "H:[v0(200)]", views: registerLabel)
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(40)]-30-|", views: loginLabel)
        view.addConstrainsWithFormat(format: "H:[v0(200)]", views: loginLabel)
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
}

























