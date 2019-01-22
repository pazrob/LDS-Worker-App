//
//  SettingsController+Handlers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension SettingsController {
    
    func openSelection(atIndexPath: IndexPath){
        let path = atIndexPath
        
        switch path{
        case [0,0]:
            //profile
            let profileController = ProfileController()
            navigationController?.pushViewController(profileController, animated: true)
        case [0,1]:
            //phone
            let phoneController = PhoneNumberController()
            navigationController?.pushViewController(phoneController, animated: true)
            
        case [2,0]:
            UIActivityViewController.inviteAFriend(viewController: self)
            
        case [2,1]:
            //Donate
            let donateController = DonateViewController()
            navigationController?.pushViewController(donateController, animated: true)
            
        case [2,2]:
            //Rate App
            let appDelegate = AppDelegate()
            appDelegate.requestReview()
            
        case [2,3]:
            //Feedback
            handleFeedback()
            
        case [3,0]:
            //Terms & Conditions
            guard let termsUrl = URL(string: LoginForm.termsLink.rawValue) else { return }
            let termsController = LegalViewController(urlPath: termsUrl)
            navigationController?.pushViewController(termsController, animated: true)
            
        case [3,1]:
            //Privacy Policy
            guard let policyUrl = URL(string: LoginForm.termsLink.rawValue) else { return }
            let privacyController = LegalViewController(urlPath:policyUrl)
            navigationController?.pushViewController(privacyController, animated: true)
            
        case [4,0]:
            //Log Out
            handleLogOut()
            
        case [4,1]:
            //Erase Account
            handleEraseAccount()
        default:
            print("ERROR: No default available")
        }
    }
    
    private func handleLogOut() {
        
        let actionSheet = UIAlertController(title: UITextSettings.signOutAlertTitle.rawValue, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: UITextSettings.signOut.rawValue, style: .destructive) { alert in
            print("Sign Out")
            try! Auth.auth().signOut()
            
            self.clearOutAndExit()
        }
        
        let cancelAction = UIAlertAction(title: UITextSettings.cancel.rawValue, style: .cancel, handler: nil)
        
        actionSheet.addAction(signOutAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func eraseAllUserData() {
        FirebaseService.currentUserProfile = nil
        ImageService.userPhoto = nil
        DataService.userGroupPosts = [Post]()
        DataService.userPersonalPosts = [Post]()
        MessageService.messageDictionary = [String:MessageModel]()
    }
    
    func handleEraseAccount() {
        
        let actionAlert = UIAlertController(title: UITextSettings.eraseAccount.rawValue,
                                            message: UITextSettings.eraseAlertMessage.rawValue,
                                            preferredStyle: .alert)
        actionAlert.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.layer.cornerRadius = 5
            textField.layer.masksToBounds = true
            textField.textAlignment = .center
            textField.font = UIFont.boldSystemFont(ofSize: 18)
            textField.placeholder = UITextSettings.erasePlaceholder.rawValue
            textField.clearButtonMode = .whileEditing
        }
        
        let eraseAccountAction = UIAlertAction(title: UITextSettings.eraseAccount.rawValue, style: .destructive) { [unowned actionAlert] action in
            if let giveTextField = actionAlert.textFields?.first, let passwordGiven = giveTextField.text {
                self.eraseUserAccount(checkPass: passwordGiven)
            }
        }
        let cancelAction = UIAlertAction(title: UITextSettings.cancel.rawValue, style: .cancel, handler: nil)
        
        actionAlert.addAction(eraseAccountAction)
        actionAlert.addAction(cancelAction)
        
        present(actionAlert, animated: true, completion: nil)
    }
    
    private func clearOutAndExit() {
        //Erase all Data
        self.eraseAllUserData()
        
        //Update UserDefaults
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        UserDefaults.standard.synchronize()
        
        //Replace Controller
        UIApplication.setRootView(with: LoginViewController(), options: UIApplication.logoutAnimation)
    }
    
    private func eraseUserAccount(checkPass password: String) {
        
        //Start Animation
        UIActivityIndicatorView.startActivityLoad(view: view)
        
        //Network call
        FirebaseService.reAuthenticate(password: password) { success, errorString in
            if success {

                //User authenticated.
                guard let uid = Auth.auth().currentUser?.uid else { return }
                guard let temple = FirebaseService.currentUserProfile?.temple else { return }
                
                //Delete photo from storage first
                //Because it needs authentication
                ImageService.deletePhotoFromStorage(uid: uid)

                FirebaseService.deleteUserAccount(completion: { successDeletion in
                    if successDeletion {

                        //User Deleted
                        FirebaseService.deleteUserTrace(uid: uid, temple: temple, completion: { successTrace in
                            if successTrace {
                                
                                //End animation
                                self.clearOutAndExit()
                                UIActivityIndicatorView.stopActivityLoad()
                                return;

                            } else {
                                //Deletion in Database Failed
                                UIActivityIndicatorView.stopActivityLoad()
                                UIAlertController.somethingWentWrongController(viewController: self)
                            }
                        })
                    } else {
                        //Deletion User Failed
                        UIActivityIndicatorView.stopActivityLoad()
                        UIAlertController.somethingWentWrongController(viewController: self)
                    }
                })
            } else {
                //Re-athenticate failed
                UIActivityIndicatorView.stopActivityLoad()
                UIAlertController.sendMessage(viewController: self, message: "Wrong Password")

            }
        }
    }
    
    @objc func performLogOut(){
        try! Auth.auth().signOut()
    }
    
}
