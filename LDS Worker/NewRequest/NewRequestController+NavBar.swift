//
//  NewRequestController+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension NewRequestController: UINavigationBarDelegate {
    
    func setUpNavigationBarForNewType(){
        
        //Nav Items
        navigationItem.title = "New Request"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(handleSend))
        
        //Send Button reference
        sendButton = navigationItem.rightBarButtonItem
        sendButton?.isEnabled = false
        
        //Navigation Controller Bar
        navigationController?.navigationBar.tintColor = UIColor.appMainColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setUpNavigationBarForEditType() {
        
        //Nav Items
        navigationItem.title = "Edit Request"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        
        //Navigation Controller Bar
        navigationController?.navigationBar.tintColor = UIColor.appMainColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func handleSend() {
        
        let sendActionSheet = UIAlertController(title: "Request will be shared with your temple group", message: nil, preferredStyle: .actionSheet)
        
        let sendAction = UIAlertAction(title: "Send", style: .default, handler: { (action: UIAlertAction) in
            self.performSendRequest()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sendActionSheet.addAction(sendAction)
        sendActionSheet.addAction(cancelAction)
        
        self.navigationController?.present(sendActionSheet, animated: true, completion: nil)
    }
    
    @objc func  handleSave(){
        
        guard let idFromPost = postId else { return }
        guard let note = mainView.noteField.text else { return }
        guard let to = mainView.timeField.text else { return }
        //Date in timestamp
        let from: Double = self.mainView.datePicker.date.timeIntervalSince1970
        
        DataService.updateEditedPost(with: idFromPost, note: note, from: from, to: to)
        
        //if this works, then update the post! so use completion/closures
        let oldPost = myRequestController?.postDetails
        
        //Update information
        oldPost?.note = note
        oldPost?.from = from
        oldPost?.to = to
        
        //Send post back
        myRequestController?.postDetails = oldPost
        
        //Go back
        navigationController?.popViewController(animated: true)
    }
    
    func performSendRequest() {
        print("gonna send!")
        
        guard let noteValue = self.mainView.noteField.text else {return}
        guard let toValue = self.mainView.timeField.text else {return}        
        //Date in timestamp
        let from: Double = self.mainView.datePicker.date.timeIntervalSince1970
                
        DataService.performSendRequest(note: noteValue, from: from, to: toValue, completion: { success in
            if success {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                UIAlertController.somethingWentWrongController(viewController: self)
            }
        })
    }
    
    @objc func handleCancel() {
        
        if isNoteEmpty {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        let cancelActionSheet = UIAlertController(title: "Are you sure you want to Cancel?", message: nil, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action: UIAlertAction) in
            self.presentingViewController?.dismiss(animated: true)
        })
        let noAction = UIAlertAction(title: "No", style: .cancel)
        
        cancelActionSheet.addAction(yesAction)
        cancelActionSheet.addAction(noAction)
        
        self.navigationController?.present(cancelActionSheet, animated: true)
    }
    
    func updateSendIsEnabled(){
        
        if (!isNoteEmpty && !isFromEmpty && !isToEmpty){
            sendButton?.isEnabled = true
            return
        }
        sendButton?.isEnabled = false
    }
    
    
}
