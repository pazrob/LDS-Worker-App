//
//  ProfileViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/15/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    let myArray = [UITextSettings.firstName.rawValue,
                   UITextSettings.lastName.rawValue,
                   UITextSettings.email.rawValue,
                   UITextSettings.temple.rawValue]
    
    var userInfo = [String]()
    var userProfile: UserProfile?
    let profileCell = "profileCell"
    let headerProfileCell = "headerProfileCell"
    
    let photoPicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    lazy var profileCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.appEmptyColor
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: profileCell)
        collection.register(HeaderProfileCell.self, forCellWithReuseIdentifier: headerProfileCell)
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.bounces = true
        return collection
    }()
    
    func fetchUserInfo() {
        
        if let userProfile = FirebaseService.currentUserProfile {
            
            userInfo.append(userProfile.firstName)
            userInfo.append(userProfile.lastName)
            userInfo.append(userProfile.email)
            userInfo.append(userProfile.temple)
        } else {
            //Should dissmis the controller
            print("Cannot load the information og user from Local Service")
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        fetchUserInfo()
        setUpNavigationBar()
        setUpViews()
    }
    
    private func setUpViews(){
        
        view.addSubview(profileCollection)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: profileCollection)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: profileCollection)
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
}
