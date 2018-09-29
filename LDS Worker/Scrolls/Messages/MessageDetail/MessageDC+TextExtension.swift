//
//  MessageDC+TextExtension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/29/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MessageDetailController : UITextViewDelegate {    
   
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            handleSend()
            return false
        }
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text)
        
        let size = CGSize(width: inputContainerView.textView.frame.width , height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
//        let estimatedHeight = estimatedSize.height - 10
//        print("Estimated Height?: \(estimatedHeight)")
        
        inputContainerView.inputFieldHeightAnchor?.constant = estimatedSize.height + 18
        

        

    }
    
}
