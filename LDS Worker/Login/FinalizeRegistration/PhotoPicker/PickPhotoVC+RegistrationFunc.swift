//
//  PickPhotoVC+RegistrationFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickPhotoViewController {
    
    // Register the user email and password, if succeeds: Upload photo
    func completeRegistration(potentialUser: UserRegistrationModel, isTherePhoto: Bool) {
        
        UIActivityIndicatorView.startActivityLoad()
        
        if isTherePhoto {
            // Save photo first, then user in database
            self.uploadPhotoAndSaveUser()
            
        } else {
            // Save user in database only
            self.saveUserIntoDatabase(photoURL: nil)
            
        }
        
    }
    
    // Uploads photo, if succeeds: Saves profile into Database
    func uploadPhotoAndSaveUser() {
        
        //1. Get picture from ImageView
        if let imageProfile = pickedImage {
            
            //2. Upload image to Firebase Storage
            ImageService.uploadPhotoToStorage(imageProfile) { url in
                
                if url == nil {
                    UIActivityIndicatorView.stopActivityLoad()
                    print("The url did not come back")
                    return
                }
                
                if let newURL = url {
                    //3. Save the profile info to Database
                    self.saveUserIntoDatabase(photoURL: newURL.absoluteString)
                }
            }
            
        } else {
            
            UIActivityIndicatorView.stopActivityLoad()
            let layout = UICollectionViewFlowLayout()
            self.navigationController?.pushViewController(HomeController(collectionViewLayout: layout), animated: true)
        }
    }
    
    // Saves user profile into Database, if succeeds: Sends to Home Controller
    func saveUserIntoDatabase(photoURL: String?) {
        
        guard let user = potentialUser else { return }
        guard let temple = user.temple else { return }
        guard let gender = user.gender else { return }
        
        FirebaseService.saveUserProfile(firstNameValue: user.firstName,
                                        lastNameValue: user.lastName,
                                        genderValue: gender,
                                        emailValue: user.email,
                                        temple: temple,
                                        photoUrl: photoURL,
                                        completion: { userWasSaved in
                                            
                                            if userWasSaved {
                                                
                                                //Save isLoggedIn in UserDefaults
                                                UserDefaults.setLoggedInUserDefault()
                                                
                                                //Send to home
                                                self.presentHomeController()
                                                FirebaseService.sendVerificationEmail()
                                                
                                            } else { 
                                                //What happens if nothing is saved?
                                                print("User was not saved")
                                            }
                                            
                                            UIActivityIndicatorView.stopActivityLoad()
        })
    }
    
    
    // Takes you to Home Controller
    func presentHomeController() {
        
        let layout = UICollectionViewFlowLayout()
        let homeViewController = HomeController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        UIApplication.setRootView(with: navigationController)
    }    
}
