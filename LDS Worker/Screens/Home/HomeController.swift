//
//  ViewController.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 4/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

// This is the first controller after authentication

class HomeController: UITabBarController {
    
    var myRequestVC = MyRequestVC()
    var groupRequestVC = GroupRequestsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading data and observing data
        FirebaseService.fetchUserProfile { userProfile in
            
            if userProfile == nil {
                print("User error")
                //MARK: send back to loginController
                return
            }
            
            //Update title
            self.title = userProfile?.temple
            
            //Update defaultPhotoString
            if userProfile?.gender == LoginForm.m.rawValue {
                ImageService.defaultPhotoString = PictureKeys.brotherDefault.rawValue
            } else {
                ImageService.defaultPhotoString = PictureKeys.sisterDefault.rawValue
            }
            
            //Load singleton user
            FirebaseService.currentUserProfile = userProfile
            
            //Network calls
            DataService.fetchPersonalPosts()
            ImageService.loadUserPicture(gender: userProfile?.gender)
        }
        
        //Check setting preferences
        let notificationOn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.notificationOn.rawValue)
        if notificationOn {
            print("*** RECEIVE NOTIFICATIONS")
        } else {
            print("**** NO NO NO NOTIFICATIONS")
        }
        
        //View SetUp
        setUpNavigationBarItems()
//        setUpCollectionView()
        
        //New
        self.myRequestVC.tabBarItem = UITabBarItem(title: "My Requests", image: nil, selectedImage: nil)
        self.groupRequestVC.tabBarItem = UITabBarItem(title: "Temple Requests", image: nil, selectedImage: nil)
        self.viewControllers = [self.myRequestVC, self.groupRequestVC]
    }
    
    
}
