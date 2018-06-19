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
    var iconTopConstraint : NSLayoutConstraint?
    var collectionBottomConstraint : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
        setUpNavigationBar()
        setUpViews()
        setUpCollectionView()
    }
    
    func setUpCollectionView(){
        //Registering the cells
        menuCollectionView.register(LoginCollectionCell.self, forCellWithReuseIdentifier: loginCellId)
        menuCollectionView.register(RegisterCollectionCell.self, forCellWithReuseIdentifier: registerCellId)
        
        //Get access to the layout
        if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        //Allows snap on horizontal cells
        menuCollectionView.isPagingEnabled = true
        menuCollectionView.showsHorizontalScrollIndicator = false
        
        //Selects the fist icon on menu
        isFirstCellActive = true
    }
    
    let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "⇦ Log In"
        label.textColor = UIColor.appPeach
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account ⇨"
        label.textColor = UIColor.appPeach
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private func setUpViews(){
        addTapGestures()
        
        view.backgroundColor = UIColor.appEmptyColor
        loginLabel.isHidden = true
        view.addSubview(appIcon)
        view.addSubview(menuCollectionView)
        view.addSubview(registerLabel)
        view.addSubview(loginLabel)
        
        view.addConstrainsWithFormat(format: "V:[v0(130)]", views: appIcon)
        view.addConstrainsWithFormat(format: "H:[v0(130)]", views: appIcon)
        iconTopConstraint = appIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 130)
        iconTopConstraint?.isActive = true
        view.addConstraint(NSLayoutConstraint(item: appIcon, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        //Constraints for the collection
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menuCollectionView)
        view.addConstrainsWithFormat(format: "V:[v0(500)]", views: menuCollectionView)
        collectionBottomConstraint = menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        collectionBottomConstraint?.isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(40)]-30-|", views: registerLabel)
        view.addConstrainsWithFormat(format: "H:[v0(200)]", views: registerLabel)
        view.addConstraint(NSLayoutConstraint(item: registerLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstrainsWithFormat(format: "V:[v0(40)]-30-|", views: loginLabel)
        view.addConstrainsWithFormat(format: "H:[v0(200)]", views: loginLabel)
        view.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    func presentHomeScreen(){
        let layout = UICollectionViewFlowLayout()
        let homeViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        self.present(homeViewController, animated: true)
    }
    
    func presentFinalizeRegistration(){
        let homeViewController = PickTempleViewController()
        //        self.present(homeViewController, animated: true)
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @objc func handleRegisterSwipe(){
        menuCollectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
    
    @objc func handleLoginSwipe(){
        menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
    
    func addTapGestures(){
        registerLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleRegisterSwipe))
        registerLabel.addGestureRecognizer(tap)
        
        loginLabel.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleLoginSwipe))
        loginLabel.addGestureRecognizer(tap2)
    }
}

























