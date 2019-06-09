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

class LoginViewController : UIViewController {
        
    
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
        cv.register(LoginCollectionCell.self, forCellWithReuseIdentifier: ID.loginCellId)
        cv.register(RegisterCollectionCell.self, forCellWithReuseIdentifier: ID.registerCellId)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    

    lazy var ihaveAccountBtn: UIButton = {
        let btn = UIButton.getAppButton(text: LoginForm.goPreviousView.rawValue)
        btn.backgroundColor = UIColor.appPeach
        btn.addTarget(self, action: #selector(self.handleLoginSwipe), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var iNeedRegisterBtn: UIButton = {
        let btn = UIButton.getAppButton(text: LoginForm.goNextView.rawValue)
        btn.backgroundColor = UIColor.appPeach
        btn.addTarget(self, action: #selector(self.handleRegisterSwipe), for: .touchUpInside)
        return btn
    }()
    
    var collectionTopConstraint: NSLayoutConstraint?
    var iconWidthAnchor: NSLayoutConstraint?
    var iconHeightAnchor: NSLayoutConstraint?
    var iconCenterAnchor: NSLayoutConstraint?
    var iconLeftAnchor: NSLayoutConstraint?
    
    private func setUpViews(){
        
        view.backgroundColor = UIColor.appEmptyColor
        ihaveAccountBtn.isHidden = true
        view.addSubview(appIcon)
        view.addSubview(loginCollection)
        view.addSubview(iNeedRegisterBtn)
        view.addSubview(ihaveAccountBtn)
        
        //LDS Worker Icon Constraints
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
        
        
        //Constraints for login label
        iNeedRegisterBtn.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                             topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40, widthConstant: 0, heightConstant: 42)
        
        //Constraints for register label
        ihaveAccountBtn.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                             topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 40, widthConstant: 0, heightConstant: 42)
    }
    
    
    
}

























