//
//  profileCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/31/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell{    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.textAlignment = .right
        return field
    }()
    
    
    override func setUpViews(){
        backgroundColor = .white
        addSubview(descriptionLabel)
        addSubview(textField)
        
        addConstrainsWithFormat(format: "H:|-14-[v0]", views: descriptionLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: descriptionLabel)
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: textField)
        addConstrainsWithFormat(format: "V:[v0]", views: textField)
        addConstraint(NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}

class HeaderProfileCell: BaseCell{
    
    var profileController : ProfileViewController?
    
    
    let imageProfile: UIImageView = {
        let imageView = UIImageView.getProfileFrame(with: "fire")
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    let titleProfile = UILabel.getH2(text: "Arizona Temple's Worker")
    
    let subtitleProfile: UILabel = {
        let label = UILabel.getLabelSubtitlePostedDefaults()
        label.text = "with LDS Worker since 2017"
        return label
    }()
    
    let divider1: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    lazy var updatePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Photo", for: .normal)
        button.addTarget(self, action: #selector(handleUpdatePhoto), for: .touchUpInside)
        return button
    }()
    
    let divider2: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    @objc func handleUpdatePhoto(){
        print("Updating photo..")
        profileController?.handleUploadImage()
    }
    
    
    override func setUpViews(){
        backgroundColor = .white
        addSubview(imageProfile)
        addSubview(titleProfile)
        addSubview(subtitleProfile)
        addSubview(divider1)
        addSubview(updatePhotoButton)
        addSubview(divider2)
     
        
        addConstrainsWithFormat(format: "H:[v0(115)]", views: imageProfile)
        addConstrainsWithFormat(format: "V:|-20-[v0(115)]", views: imageProfile)
        addConstraint(NSLayoutConstraint(item: imageProfile, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]", views: titleProfile)
        addConstrainsWithFormat(format: "V:[v0]", views: titleProfile)
        addConstraint(NSLayoutConstraint(item: titleProfile, attribute: .top, relatedBy: .equal, toItem: imageProfile, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: titleProfile, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]", views: subtitleProfile)
        addConstrainsWithFormat(format: "V:[v0]", views: subtitleProfile)
        addConstraint(NSLayoutConstraint(item: subtitleProfile, attribute: .top, relatedBy: .equal, toItem: titleProfile, attribute: .bottom, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: subtitleProfile, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider1)
        addConstraint(NSLayoutConstraint(item: divider1, attribute: .top, relatedBy: .equal, toItem: updatePhotoButton, attribute: .top, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: updatePhotoButton)
        addConstrainsWithFormat(format: "V:[v0(50)]|", views: updatePhotoButton)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider2)
    }
    
}
