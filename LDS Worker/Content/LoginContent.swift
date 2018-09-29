//
//  LoginContent.swift
//  LDS Worker
//
//  Created by Robinson Paz on 7/31/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

enum LoginForm: String {
    
    case firstNameString = "First Name"
    case lastNameString = "Last Name"
    case emailString = "Email"
    case passwordString = "Password"
    case registerString = "Get Started"
    case signInString = "Sign In"
    case forgotPassString = "Forgot Password?"
    case goNextView = "I have an Account"
    case goPreviousView = "I need to Register"
    
    //Gender Pick
    case male = "Brother"
    case female = "Sister"
    case m = "m"
    case f = "f"
    
    
    //Legal
    case agreement = "By Registering, you agree to LDS Worker's \n Terms and Conditions and Data Policy."
    case termsLink = "https://www.ldsworker.org/terms-and-conditions"
    case policyLink = "https://www.ldsworker.org/privacy-policy"
}

enum AppContent: String {
    case statusPositive = "covered"
    case statusNegative = "uncovered"
}
