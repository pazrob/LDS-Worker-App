//
//  GroupRequestDC+Button.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI

extension GroupRequestDetailController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMessageButton() {
        
        //Get Phone
        guard let post = postDetails else { return }
        
        guard let phoneNumber = post.phone else { return }
        let lastName = post.lastName
        let genderTitle = post.getGenderTitle()
        let dateOf = Date.getStringDate(with: post.from)
        
        if !MFMessageComposeViewController.canSendText() {
            UIAlertController.sendMessage(viewController: self, message: "SMS services are not available")
            
        } else {
            
            //Delegate
            let controller = MFMessageComposeViewController()
            
            // Configure the fields of the interface
            controller.messageComposeDelegate = self
            controller.recipients = [phoneNumber]
            controller.body = "Hi \(genderTitle) \(lastName) do you still need replacement for temple on \(dateOf)?"
            
            // Present the view controller modally.
            self.present(controller, animated: true, completion: nil)
        }
       
    }
    
    @objc func handleCallButton() {
        
        //Get Phone
        guard let phone = postDetails?.phone, let number = URL(string: "tel://" + phone) else { return }
        
        //Make call
        UIApplication.shared.open(number)
        
    }
    
    
}
