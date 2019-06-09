//
//  NewRequestController+FieldsFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//


import UIKit

extension NewRequestController {

    func setUpToolBars(){
        //Toolbar for requestDescription
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleTextDone))
        toolBar.setItems([flexSpace,done], animated: false)
        mainView.noteField.inputAccessoryView = toolBar
    }
    
    func joinFieldsAndPickers(){
        //date field and picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleDateDone))
        toolBar.setItems([flexSpace,done], animated: false)
        mainView.dateField.inputAccessoryView = toolBar
        mainView.dateField.inputView = mainView.datePicker
        
        //time field and picker
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        let flexSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTimeDone))
        toolBar2.setItems([flexSpace2,done2], animated: false)
        mainView.timeField.inputAccessoryView = toolBar2
        mainView.timeField.inputView = mainView.timePicker
    }
    
    //Handlers
    @objc private func handleDateDone(){
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        formater.dateFormat = "E, MMM d' - 'h:mm a"
        let dateString = formater.string(from: mainView.datePicker.date)
        
        mainView.dateField.text = dateString
        mainView.timeField.becomeFirstResponder()
        
        if(mainView.dateField.text?.count != 0){
            isFromEmpty = false
            updateSendIsEnabled()
        }
    }
    
    @objc private func handleTimeDone(){
        let formater = DateFormatter()
        formater.dateStyle = .none
        formater.timeStyle = .short
        formater.dateFormat = "h:mm a"
        let dateString = formater.string(from: mainView.timePicker.date)
        
        mainView.timeField.text = dateString
        self.mainView.endEditing(true)
        if(mainView.timeField.text?.count != 0){
            isToEmpty = false
            updateSendIsEnabled()
        }
    }
    
    @objc private func handleTextDone(){
        mainView.dateField.becomeFirstResponder()
    }

}
