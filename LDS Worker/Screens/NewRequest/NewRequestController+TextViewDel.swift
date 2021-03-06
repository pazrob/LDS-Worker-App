//
//  RequestController+Extension.swift
//  LDS Worker
//
//  Created by Robinson Paz 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension NewRequestController: UITextViewDelegate, UIScrollViewDelegate{ //erase uscroll?
    
    //Updates counter, isNoteEmpty
    func textViewDidChange(_ textView: UITextView) {
        let lenght = textView.text.count
        mainView.counterLabel.text = "\(lenght)/150"
        isNoteEmpty = (lenght == 0) ? true : false
        updateSendIsEnabled()
    }
    
    //Limits the text to 150 characters.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = mainView.noteField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 150
    }
    
    //Hides keyboard when touching screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
}
