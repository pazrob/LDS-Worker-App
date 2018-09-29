//
//  TableViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/26/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI

class ContactsController: UICollectionViewController, MFMessageComposeViewControllerDelegate {
    
    
    
    var baseWorkers : [UserModel]?
    var sortedWorkers = [ (key: Character, value: [UserModel]) ]()
    var filteredWorkers =   [Character : [UserModel]]()
    let tableViewId = "tableViewId"
    let headerId = "headerId"
    var homeControllerRef: HomeController?
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWorkers()
        setUpNavigationBar()
        setUpCollectionView()
    }
    
    func callCellPhone(name: String, number: String) {
        
        let callController = UIAlertController(title: name, message: String.getNumberedFormated(phone: number), preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.default) { alert in
            //Making the call
            guard let numberToCall = URL(string: "tel://" + number) else { return }
            UIApplication.shared.open(numberToCall)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        callController.addAction(callAction)
        callController.addAction(cancelAction)
        
        present(callController, animated: true, completion: nil)
    }
    
    func messagePhone(fullName: String, number: String) {
        
        let messageController = UIAlertController(title: fullName, message: String.getNumberedFormated(phone: number), preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "Message", style: UIAlertActionStyle.default) { alert in
            //Send message
            self.handleMessageButton(number: number)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        messageController.addAction(callAction)
        messageController.addAction(cancelAction)
        
        present(messageController, animated: true, completion: nil)
        
    }
    
    func handleMessageButton(number: String) {
        
        if !MFMessageComposeViewController.canSendText() {
            UIAlertController.sendMessage(viewController: self, message: "SMS services are not available")
            
        } else {
            
            //Delegate
            let controller = MFMessageComposeViewController()
            
            // Configure the fields of the interface
            controller.messageComposeDelegate = self
            controller.recipients = [number]
//            controller.body = "Hi \(genderTitle) \(lastName)."
            
            // Present the view controller modally.
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}
