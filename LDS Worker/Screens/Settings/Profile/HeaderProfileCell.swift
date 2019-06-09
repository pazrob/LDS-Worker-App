//
//  HeaderProfileCell.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/19/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class HeaderProfileView: UIView {
    
    var profileController : ProfileController?
    
    let imageProfile: UIImageView = {
        let imageView = UIImageView.getProfileFrame(with: ImageService.defaultPhotoString)
        imageView.layer.cornerRadius = 58
        return imageView
    }()
    
    let titleProfile = UILabel.getH2(text: "Default Temple")
    
    let divider1: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    lazy var updatePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(UITextSettings.updatePhoto.rawValue, for: .normal)
        button.addTarget(self, action: #selector(handleUpdatePhoto), for: .touchUpInside)
        return button
    }()
    
    let divider2: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    lazy var deletePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(UITextSettings.deletePhoto.rawValue, for: .normal)
        button.addTarget(self, action: #selector(handleDeletePhoto), for: .touchUpInside)
        return button
    }()
    
    let divider3: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.rgb(red: 217, green: 217, blue: 217)
        return myView
    }()
    
    @objc func handleUpdatePhoto(){
        profileController?.handleUploadImage()
    }
    
    @objc func handleDeletePhoto(){
        profileController?.handleDeleteImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(imageProfile)
        addSubview(titleProfile)
        addSubview(divider1)
        addSubview(updatePhotoButton)
        addSubview(divider2)
        addSubview(deletePhotoButton)
        addSubview(divider3)
        
        addConstrainsWithFormat(format: "H:[v0(116)]", views: imageProfile)
        addConstrainsWithFormat(format: "V:|-20-[v0(116)]", views: imageProfile)
        imageProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]", views: titleProfile)
        addConstrainsWithFormat(format: "V:[v0]", views: titleProfile)
        titleProfile.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 10).isActive = true
        titleProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider1)
        divider1.topAnchor.constraint(equalTo: titleProfile.bottomAnchor, constant: 15).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: updatePhotoButton)
        addConstrainsWithFormat(format: "V:[v0(50)]", views: updatePhotoButton)
        updatePhotoButton.topAnchor.constraint(equalTo: divider1.bottomAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider2)
        divider2.topAnchor.constraint(equalTo: updatePhotoButton.bottomAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: deletePhotoButton)
        addConstrainsWithFormat(format: "V:[v0(50)]", views: deletePhotoButton)
        deletePhotoButton.topAnchor.constraint(equalTo: updatePhotoButton.bottomAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider3)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: divider3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
