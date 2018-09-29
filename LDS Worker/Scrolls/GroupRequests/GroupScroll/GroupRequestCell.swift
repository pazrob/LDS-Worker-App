//
//  GroupRequestsCollectionViewCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class GroupRequestCell: BaseCell {
    
    @objc func handleDefaultCell(){
        backgroundColor = UIColor.white
    }
    
    //View Cell Containers
    let containerView :UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //Circle subview
    let userProfileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    //Line Separator subview
    let separatorView:UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.appLightGray
        return view
    }()
    //Tittle label subview
    let nameTitle:UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder: Name"
        return label
    }()
    //Specifics label subview
    let specifics: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.text = "Placeholder: Specifics"
        return label
    }()
    //Status label subview
    let status: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppContent.statusNegative.rawValue
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let backDot: UIView = {
        let backV = UIView.getContainer()
        backV.layer.cornerRadius = 9
        return backV
    }()
    let genderDot: UIView = {
        let gView = UIView()
        gView.backgroundColor = .gray
        gView.translatesAutoresizingMaskIntoConstraints = false
        gView.layer.cornerRadius = 6
        return gView
    }()
    //Adds the subviews in the cell
    override func setUpViews(){
        
        backgroundColor = UIColor.white
        
        addSubview(containerView)
        addSubview(userProfileImageView)
        
        addSubview(backDot)
        addSubview(genderDot)
        
        containerView.addSubview(nameTitle)
        containerView.addSubview(status)
        containerView.addSubview(specifics)
        addSubview(separatorView)
        
        addConstrainsWithFormat(format: "H:|-82-[v0]-14-|", views: containerView)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        addConstrainsWithFormat(format: "H:|-14-[v0(60)]", views: userProfileImageView)
        addConstrainsWithFormat(format: "V:[v0(60)]", views: userProfileImageView)
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0(12)]", views: genderDot)
        addConstrainsWithFormat(format: "V:[v0(12)]", views: genderDot)
        genderDot.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor, constant: 22).isActive = true
        genderDot.centerXAnchor.constraint(equalTo: userProfileImageView.centerXAnchor, constant: 22).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0(18)]", views: backDot)
        addConstrainsWithFormat(format: "V:[v0(18)]", views: backDot)
        backDot.centerYAnchor.constraint(equalTo: genderDot.centerYAnchor).isActive = true
        backDot.centerXAnchor.constraint(equalTo: genderDot.centerXAnchor).isActive = true
        

        containerView.addConstrainsWithFormat(format: "H:|[v0]|", views: nameTitle)
        containerView.addConstrainsWithFormat(format: "V:|[v0(20)]", views: nameTitle)
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]", views: status)
        containerView.addConstraint(NSLayoutConstraint(item: specifics, attribute: .left, relatedBy: .equal, toItem: status, attribute: .right, multiplier: 1, constant: 0))
        containerView.addConstrainsWithFormat(format: "V:|-20-[v0(20)]", views: status)
        containerView.addConstrainsWithFormat(format: "V:|-20-[v0(20)]", views: specifics)
        
        addConstrainsWithFormat(format: "H:|-80-[v0]|", views: separatorView)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: separatorView)
        
    }
    
    
    
}


