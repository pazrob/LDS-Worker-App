//
//  AppDelegate.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 4/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase
import SwiftyStoreKit
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //In-App purchase
        completeTrasactions()
        
        //Give access to the view through the code, this window is the whole container
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController(rootViewController: PickGenderController())
        
        //Firebase library to configure APIs
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = false
        
        //Check if app is bloqued
        FirebaseService.isAppBloqued { [unowned self] isBloqued in
            
            if isBloqued {
                
                //Send to app bloqued controller
                self.window?.rootViewController = UINavigationController(rootViewController: AppBloquedViewController())
                return
            }
            
            //Navigation Bar color and shadow
            UINavigationBar.appearance().barTintColor = UIColor.appEmptyColor
            application.statusBarStyle = .lightContent
            
            //Listens to user logged-in state
            self.assignController()
        }
        
        
        return true
    }
    
    func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
    func observeInternetConnection() {
        
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            
            if snapshot.value as? Bool ?? false {
                print("Connected")
            } else {
                let atController = self.window?.rootViewController
                UIAlertController.sendMessage(viewController: atController, message: "There is no internet connection.")
            }
        })
        
    }
    
    
    //Asigns the VC based on logged status
    func assignController() {
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue) {
            //User is logged in
            let layout = UICollectionViewFlowLayout()
            self.window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
            
        } else {
            //User is NOT logged in
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
    
    //
    func completeTrasactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
    
    
}

