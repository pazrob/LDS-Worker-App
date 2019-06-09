//
//  MyRequestDC+1.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestDetailController {
    
    @objc func handleChangeStatusRequest(){
        
        let actionSheet = UIAlertController(title: "Are you sure you want to change the status?", message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.handleSwitchStatus()
            
            if let postId = self.postDetails?.id, let statusNow = self.postDetails?.status {
                DataService.updatePostStatus(with: postId, status: statusNow)
            }
        })
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func handleDeleteRequest(){
        
        let actionSheet = UIAlertController(title: "You won't be able to recover this request", message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
            
            if let postId = self.postDetails?.id {
                DataService.deletePost(with: postId)
            }
            self.navigationController?.popViewController(animated: true)
        })
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func handleSwitchStatus(){
        if let currentStatus = postDetails?.status{
            postDetails?.status = !currentStatus
            updateStatus()
        }
    }
    
    func updateStatus(){
        if let currentStatus = postDetails?.status {
            if(currentStatus){
                myRequestDetailView.statusField.text = AppContent.statusPositive.rawValue
                myRequestDetailView.statusField.textColor = UIColor.appMainColor
                myRequestDetailView.statusButton.backgroundColor = UIColor.lightGray
                myRequestDetailView.statusButton.setTitle("Mark as Uncovered", for: .normal)
            }
            else{
                myRequestDetailView.statusField.text = AppContent.statusNegative.rawValue
                myRequestDetailView.statusField.textColor = UIColor.appUncovered
                myRequestDetailView.statusButton.backgroundColor = UIColor.appMainColor
                myRequestDetailView.statusButton.setTitle("Mark as Covered", for: .normal)
            }
        }
    }
    
}
