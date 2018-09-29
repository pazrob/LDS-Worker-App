//
//  TextView+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UITextView{
    
    static func getAppTextNoteDefaults() -> UITextView{
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Notes"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.font = textView.font?.withSize(15)
        textView.isEditable = false
        textView.textAlignment = .left
        return textView
    }
    
    static func getH2(isEditable: Bool) -> UITextView{
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isEditable = isEditable
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        return textView
    }
    
    static func getAgreement() -> UITextView {
        
        //Text
        let attributedString = NSMutableAttributedString(string: LoginForm.agreement.rawValue)
        
        //Attributes
        let termsAttributes: [NSAttributedStringKey: Any] = [
            .link: NSURL(string: LoginForm.termsLink.rawValue )as Any,
            .foregroundColor: UIColor.appMainColor,
            .underlineStyle: true,
            ]
        let policyAttributes: [NSAttributedStringKey: Any] = [
            .link: NSURL(string: LoginForm.policyLink.rawValue ) as Any,
            .foregroundColor: UIColor.appMainColor,
            .underlineStyle: true
        ]
        attributedString.setAttributes(termsAttributes, range: NSMakeRange(44, 20))
        attributedString.setAttributes(policyAttributes, range: NSMakeRange(69, 11))
        
        //UITextView
        let textView = UITextView()
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .darkGray
        return textView
    }
    
    
}
