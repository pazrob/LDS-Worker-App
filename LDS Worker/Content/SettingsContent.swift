//
//  AppTextContent.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

enum UITextSettings: String {
    
    //Nav Bar
    case settings = "Settings"
    case done = "Done"
    
    //Cell titles
    case profile = "Profile"
    case updatePhoneNumber = "Update Phone Number"
    case receiveNotifications = "Receive Notifications"
    case share = "Invite Friends"
    case donate = "Donate"
    case rateApp = "Rate App"
    case feedback = "Feedback"
    case termsAndConditions = "Terms & Conditions"
    case dataPolicy = "Privacy Policy"
    case signOut = "Sign Out"
    case eraseAccount = "Erase Account"
    
    //Section titles
    case templeWorkerAccount = "TEMPLE WORKER ACCOUNT"
    case preferences = "PREFERENCES"
    case miscellaneous = "MISCELLANEOUS"
    case legal = "LEGAL"
    case empty = ""
    
    //Copyright titles
    case copyright = "© LDS Worker"
    case version = "Version 1.0"
    
    //Profile content
    case save = "Save"
    case worker = "Worker"
    case updatePhoto = "Update Photo"
    case deletePhoto = "Delete Photo"
    case memberSince = "Member since "
    case firstName = "FIRST NAME:"
    case lastName = "LAST NAME:"
    case email = "EMAIL:"
    case temple = "TEMPLE:"
    
    //Phone Number
    case updatePhone = "Update Phone"
    case deletePhone = "Delete Phone"
    
    // Donate content
    case donateTitle = "Only if you can!"
    
    //Feedback content
    case messageBody = "Hello LDS Worker team,\n"
    case subject = "LDS Worker - Feedback"
    case recipient = "robinson.paz.jesus@gmail.com"
    
    //Sign out alert
    case signOutAlertTitle = "Are you sure you want to sign out?"
    case cancel = "Cancel"
    
    //Erase account alert
    case eraseAlertMessage = "This is a non-reversible action and all data will be deleted. Please provide the password for your account."
    case erasePlaceholder = "password"
    
    //Invite Friend
    case inviteFriendText = "I am using this LDS Worker app, here it is the link to download it! \n www.ldsworker.org"
    
}
