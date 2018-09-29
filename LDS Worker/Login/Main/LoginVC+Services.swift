//
//  LoginVC+Buttons.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController {
    
    func handleRegister(potentialUser: UserRegistrationModel) {
        
        //UI update
        view.endEditing(true)
        UIActivityIndicatorView.startActivityLoad(view: self.view)
        
        FirebaseService.performRegister(email: potentialUser.email, password: potentialUser.password) { success, errorMessage in
            
            if success {
                
                //Finalize Registration
                UIActivityIndicatorView.stopActivityLoad()
                self.presentFinalizeRegistration(potentialUser: potentialUser)
                
            } else {
                
                //Send error message
                UIActivityIndicatorView.stopActivityLoad()
                if let errorText = errorMessage {
                    UIAlertController.sendMessage(viewController: self, message: errorText)
                }
            }
        }
    }
    
    func presentFinalizeRegistration(potentialUser: UserRegistrationModel){
        
        //MARK: end bool to default = isRegistrationComplete? -> FALSE
        
        let templePickerController = PickTempleViewController()
        templePickerController.potentialUser = potentialUser
        let finalizeController = UINavigationController(rootViewController: templePickerController)
        present(finalizeController, animated: true, completion: nil)
    }
    
    func handleLogin(email: String, password: String) {
        
        //UI update
        view.endEditing(true)
        UIActivityIndicatorView.startActivityLoad(view: self.view)
        
        
        FirebaseService.performLogin(email: email, password: password) { success, error in
            
            if success {
                //Send Home Page
                UserDefaults.setLoggedInUserDefault()
                UIActivityIndicatorView.stopActivityLoad()
                self.presentHomeController()
                
            } else {
                
                //Send error message
                UIActivityIndicatorView.stopActivityLoad()
                if let errorText = error?.localizedDescription {
                    UIAlertController.sendMessage(viewController: self, message: errorText)
                }
            }
        }
    }
    

    
    func presentHomeController() {
        
        let layout = UICollectionViewFlowLayout()
        let homeViewController = HomeController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        UIApplication.setRootView(with: navigationController)
    }
}
