//
//  SettingsController+Mail.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI


extension SettingsController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleFeedback(){
        let composeCV = MFMailComposeViewController()
        composeCV.mailComposeDelegate = self
        
        if(MFMailComposeViewController.canSendMail()){
            
            //Configure the fields of the interface
            composeCV.setMessageBody(UITextSettings.messageBody.rawValue, isHTML: false)
            composeCV.setSubject(UITextSettings.subject.rawValue)
            composeCV.setToRecipients([UITextSettings.recipient.rawValue])
            
            //Present the ViewController
            composeCV.navigationController?.navigationBar.backgroundColor = .red
            composeCV.navigationController?.navigationBar.tintColor = .red
            present(composeCV, animated: true, completion: nil)
        }
        else{
            print("Cannot send Mail")
        }
    }
    
}
