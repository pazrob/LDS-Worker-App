//
//  HomeTableViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/15/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//
//
//import UIKit
//
//class HomeTableViewController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setUpCustomViewControllers()
//    }
//    
//    private func setUpCustomViewControllers(){
//        
//        let layout = UICollectionViewFlowLayout()
//        let homeController = HomeController(collectionViewLayout: layout)
//        let homeTab = UINavigationController(rootViewController: homeController)
//        homeTab.tabBarItem.title = "Home"
//        homeTab.tabBarItem.image = UIImage(named: "recent")
//        
//        let requestPopup = UIStoryboard(name: "Request", bundle: nil)
//        let popupViewController = requestPopup.instantiateInitialViewController()
//        popupViewController?.tabBarItem.image = UIImage(named: "requestCall")
//        
//        let inviteViewController = UIViewController()
//        inviteViewController.tabBarItem.title = "Invite"
//        inviteViewController.tabBarItem.image = UIImage(named: "groups")
//        
//        viewControllers = [homeTab, popupViewController!, inviteViewController]
//    }
//    
//    
//
//}
