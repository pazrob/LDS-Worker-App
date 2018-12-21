//
//  MyRequestDC+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestDetailController{
    
    func setUpNavigationBar(){
        
        //Title Attributes
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.title = "My Request"
        
        //Nav Items
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit(sender:)))
        self.navigationItem.rightBarButtonItem?.isEnabled = !isExpired
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
    }
    
    @objc func handleEdit(sender: UIBarButtonItem){
        
        let editRequestController = NewRequestController()
        let editModel = RequestEdit()
        editModel.note = postDetails?.note
        editModel.from = postDetails?.from
        editModel.to = postDetails?.to
        editRequestController.requestToEdit = editModel
        editRequestController.myRequestController = self
        editRequestController.postId = postDetails?.id
        self.navigationController?.pushViewController(editRequestController, animated: true)
    }
    
    @objc func cancelEditing(){
        self.dismiss(animated: true, completion: nil)
    }
}
