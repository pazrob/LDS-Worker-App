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
    
    func fetchUserInfo() {
        if let userProfile = FirebaseService.currentUserProfile {
            userInfo.append(userProfile.firstName)
            userInfo.append(userProfile.lastName)
            userInfo.append(userProfile.email)
            userInfo.append(userProfile.temple)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    var headerView = HeaderProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        fetchUserInfo()
        setUpNavigationBar()
        setUpViews()
    }
    
    private func setUpViews(){
        view.addSubview(headerView)
        headerView.fillSuperview()
    }
 
}
