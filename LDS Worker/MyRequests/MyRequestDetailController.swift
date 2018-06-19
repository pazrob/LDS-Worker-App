//
//  RequestDetailViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI

extension MyRequestDetailController{
    
    private func setUpNavigationStyle(){
        navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "My Request"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit(sender:)))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
    }
    
    @objc func handleEdit(sender: UIBarButtonItem){
        
        let editRequestController = EditRequestController()
        let editModel = NewRequestModel()
        editModel.note = postDetails?.note
        editModel.fromDate = postDetails?.from
        editModel.toDate = postDetails?.to
        editRequestController.requestToEdit = editModel
        self.navigationController?.pushViewController(editRequestController, animated: true)
    }
    
    @objc func cancelEditing(){
        self.dismiss(animated: true, completion: nil)
    }
}


class MyRequestDetailController: UIViewController, MFMessageComposeViewControllerDelegate{
    
    var isExpired: Bool?
    
    var postDetails: Post?{
        didSet{
            
            if postDetails?.author.imageURL != nil {
                guard let profileImage = ImageService.userPhoto else { return }
                profilePicture.image = profileImage
            }
            
            if let last = postDetails?.author.lastName, let first = postDetails?.author.firstName {
                nameLabel.text = "\(last), \(first)"
            }
            
            if let postedOn = postDetails?.timeStamp {
                posted.text = "Posted \(postedOn)"
            }
            
            if let description = postDetails?.note {
                requestDescription.text = description
            }
            
            if let from = postDetails?.from {
                fromField.text = from
            }
            if let to = postDetails?.to {
                toField.text = to
            }
            if postDetails?.status != nil {
                updateStatus()
            }
        }
    }
    
    let headerView = UIView.getContainer()
    let bodyView = UIView.getContainer()
    
    let profilePicture = UIImageView.getProfileFrame(with: "defaultPortrait")
    let nameLabel: UILabel = {
        let label = UILabel.getH2(text: "Name")
        label.textAlignment = .center
        return label
    }()
    let posted = UILabel.getLabelSubtitlePostedDefaults()
    let divider1 = UIView.getDivider()
    let divider2 = UIView.getDivider()
    let divider3 = UIView.getDivider()
    let divider4 = UIView.getDivider()
    let divider5 = UIView.getDivider()
    let divider6 = UIView.getDivider()
    
    let requestDescription = UITextView.getH2(isEditable: false)
    let fromField = UILabel.getH3(text: "")
    let toField = UILabel.getH3(text: "")
    let statusField = UILabel.getH3(text: "")
    

    let labelNote = UILabel.getLabelDescriptionDefaults(text: "NOTE:")
    let fromLabel = UILabel.getLabelDescriptionDefaults(text: "FROM:")
    let toLabel = UILabel.getLabelDescriptionDefaults(text: "TO:")
    let labelStatus = UILabel.getLabelDescriptionDefaults(text: "STATUS:")
    
    
    let statusButton: UIButton = {
        let btn = UIButton.getAppButton(text: "Button")
        btn.addTarget(self, action: #selector(handleChangeStatusRequest), for: .touchUpInside)
        return btn
    }()
    let deleteButton: UIButton = {
        let btn = UIButton.getAppGhostButton(text: "Delete Request")
        btn.addTarget(self, action: #selector(handleDeleteRequest), for: .touchUpInside)
        return btn
    }()
    let expiredWarningLabel = UILabel.getLabelFooterDefaults(text: "This request is expired")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        setUpNavigationStyle()
        setUpViews()
        
    }
    
    func filterViewsByExpiration(){
        if let requestExpired = isExpired{
            if requestExpired{
                statusButton.isHidden = true
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                expiredWarningLabel.isHidden = true
            }
        }
    }
    
    private func setUpViews(){
        
        view.addSubview(headerView)
        view.addSubview(bodyView)
        
        headerView.addSubview(profilePicture)
        headerView.addSubview(nameLabel)
        headerView.addSubview(posted)
        headerView.addSubview(divider1)
        
        bodyView.addSubview(divider2)
        bodyView.addSubview(labelNote)
        bodyView.addSubview(requestDescription)
        bodyView.addSubview(divider3)
        bodyView.addSubview(fromLabel)
        bodyView.addSubview(fromField)
        bodyView.addSubview(divider4)
        bodyView.addSubview(toLabel)
        bodyView.addSubview(toField)
        bodyView.addSubview(divider5)
        bodyView.addSubview(labelStatus)
        bodyView.addSubview(statusField)
        bodyView.addSubview(divider6)
        
        view.addSubview(expiredWarningLabel)
        view.addSubview(statusButton)
        view.addSubview(deleteButton)
        
        filterViewsByExpiration()
        
        //Header Container
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: headerView)
        view.addConstrainsWithFormat(format: "V:|[v0]", views: headerView)
        view.addConstraint(NSLayoutConstraint(item: headerView, attribute: .bottom, relatedBy: .equal, toItem: posted, attribute: .bottom, multiplier: 1, constant: 10))
        //Body Container
        view.addConstraint(NSLayoutConstraint(item: bodyView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 30))
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: bodyView)
        view.addConstrainsWithFormat(format: "V:[v0]", views: bodyView)
        view.addConstraint(NSLayoutConstraint(item: bodyView, attribute: .bottom, relatedBy: .equal, toItem: labelStatus, attribute: .bottom, multiplier: 1, constant: 20))
        //Profile Picture
        view.addConstrainsWithFormat(format: "H:[v0(100)]", views: profilePicture)
        view.addConstrainsWithFormat(format: "V:|-20-[v0(100)]", views: profilePicture)
        view.addConstraint(NSLayoutConstraint(item: profilePicture, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        //Name Label
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: nameLabel)
        view.addConstrainsWithFormat(format: "V:[v0(20)]", views: nameLabel)
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profilePicture, attribute: .bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        //Posted Label Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: posted)
        view.addConstrainsWithFormat(format: "V:[v0(10)]", views: posted)
        view.addConstraint(NSLayoutConstraint(item: posted, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 3))
        view.addConstraint(NSLayoutConstraint(item: posted, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        //Separator Line Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider1)
        //Separator Line Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        view.addConstrainsWithFormat(format: "V:|[v0(0.3)]", views: divider2)
        //Label Note Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: labelNote)
        view.addConstrainsWithFormat(format: "V:|-20-[v0]", views: labelNote)
        //Description Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: requestDescription)
        view.addConstrainsWithFormat(format: "V:[v0(50)]", views: requestDescription)
        view.addConstraint(NSLayoutConstraint(item: requestDescription, attribute: .top, relatedBy: .equal, toItem: labelNote, attribute: .bottom, multiplier: 1, constant: 5))
        //Separator Line Constraints
        view.addConstraint(NSLayoutConstraint(item: divider3, attribute: .top, relatedBy: .equal, toItem: requestDescription, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider3)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider3)
        //Label from Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: fromLabel)
        view.addConstraint(NSLayoutConstraint(item: fromLabel, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .bottom, multiplier: 1, constant: 15))
        //From Field
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: fromField)
        view.addConstraint(NSLayoutConstraint(item: fromField, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .top, multiplier: 1, constant: 5))
        //Divider 4
        view.addConstraint(NSLayoutConstraint(item: divider4, attribute: .top, relatedBy: .equal, toItem: fromLabel, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider4)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider4)
        //Label to Constraints
        view.addConstraint(NSLayoutConstraint(item: toLabel, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: toLabel)
        //To Field
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: toField)
        view.addConstraint(NSLayoutConstraint(item: toField, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 5))
//        Divider 5
        view.addConstraint(NSLayoutConstraint(item: divider5, attribute: .top, relatedBy: .equal, toItem: toField, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider5)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider5)
        //Label to Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]", views: labelStatus)
        view.addConstrainsWithFormat(format: "V:[v0]", views: labelStatus)
        view.addConstraint(NSLayoutConstraint(item: labelStatus, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .bottom, multiplier: 1, constant: 15))
        //Status Constraints
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: statusField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: statusField)
        view.addConstraint(NSLayoutConstraint(item: statusField, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .top, multiplier: 1, constant: 5))
        // Divider 6
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider6)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: divider6)
        //Expiration Warning Button Constraints
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: expiredWarningLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: expiredWarningLabel)
        view.addConstraint(NSLayoutConstraint(item: expiredWarningLabel, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 5))
        //Status Button Constraints
        view.addConstrainsWithFormat(format: "H:|-40-[v0]-40-|", views: statusButton)
        view.addConstrainsWithFormat(format: "V:[v0(42)]", views: statusButton)
        view.addConstraint(NSLayoutConstraint(item: statusButton, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: statusButton, attribute: .centerX, relatedBy: .equal, toItem: bodyView, attribute: .centerX, multiplier: 1, constant: 0))
        //Delete Button Constraints
        view.addConstrainsWithFormat(format: "H:|-40-[v0]-40-|", views: deleteButton)
        view.addConstrainsWithFormat(format: "V:[v0(42)]", views: deleteButton)
        view.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: statusButton, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .centerX, relatedBy: .equal, toItem: statusButton, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    @objc func handleChangeStatusRequest(){
        let actionSheet = UIAlertController(title: "Are you sure you want to change the status?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) in
            self.handleSwitchStatus()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func handleDeleteRequest(){
        let actionSheet = UIAlertController(title: "You won't be able to recover this request", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
            print("deleting...")
            self.navigationController?.popViewController(animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func handleSwitchStatus(){
        if let currentStatus = postDetails?.status{
            postDetails?.status = !currentStatus
            updateStatus()
        }
    }
    
    private func updateStatus(){
        if let currentStatus = postDetails?.status {
            if(currentStatus){
                statusField.text = "Covered"
                statusField.textColor = UIColor.appMainColor
                statusButton.backgroundColor = UIColor.lightGray
                statusButton.setTitle("Mark as Uncovered", for: .normal)
            }
            else{
                statusField.text = "Uncovered"
                statusField.textColor = UIColor.appUncovered
                statusButton.backgroundColor = UIColor.appMainColor
                statusButton.setTitle("Mark as Covered", for: .normal)
            }//Send Change to database?
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Check the result
        
        // Dismiss VC
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
















