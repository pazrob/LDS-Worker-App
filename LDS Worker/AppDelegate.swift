//
//  AppDelegate.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 4/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import StoreKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
//        val database = FirebaseDatabase.getInstance()
//        database.setPersistenceEnabled(true)
        
        //Give access to the view through the code, this window is the whole container
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: PickGenderController())
        
        //Navigation Bar color and shadow
        UINavigationBar.appearance().barTintColor = UIColor.appEmptyColor
//        UINavigationBar.appearance().shadowImage = UIImage()
        application.statusBarStyle = .lightContent
        
        //Listens to user logged-in state
        assignController()
        
        return true
    }
    
    func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
    func assignController() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            //User is logged in
            print("The user isLoggedIn")
            let layout = UICollectionViewFlowLayout()
            self.window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
            
        } else {
            //User is NOT logged in
            print("NO isLoggedIn")
            let loginViewController = LoginViewController()
            self.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

