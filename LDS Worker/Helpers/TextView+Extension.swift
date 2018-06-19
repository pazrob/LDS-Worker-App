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
    
    
}
