//
//  GroupRequestDC+Button.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI

extension GroupRequestDC: MFMessageComposeViewControllerDelegate {
    
    @objc func handleMessageButton() {
        guard let post = postDetails else { return }
        guard let phoneNumber = post.phone else { return }
        let lastName = post.lastName
        let genderTitle = post.getGenderTitle()
        let dateOf = Date.getStringDate(with: post.from)
        
        if !MFMessageComposeViewController.canSendText() {
            UIAlertController.sendMessage(viewController: self, message: "SMS services are not available")
        } else {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            controller.recipients = [phoneNumber]
            controller.body = "Hi \(genderTitle) \(lastName) do you still need replacement for temple on \(dateOf)?"
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    /// Handle errors
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Make a call action
    @objc func handleCallButton() {
        guard let phone = postDetails?.phone, let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
}
