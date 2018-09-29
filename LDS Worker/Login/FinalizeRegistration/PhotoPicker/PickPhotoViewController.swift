//
//  PickPhotoViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/7/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class PickPhotoViewController: UIViewController {
    
    var potentialUser: UserRegistrationModel?
    var pickedImage: UIImage?
    var isPhotoSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpNavBar()
        setUpViews()
    }
    
    let explainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Add your Photo"
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        label.textAlignment = .center
//        label.backgroundColor = .red
        return label
    }()
    
    lazy var imageProfile: UIImageView = {
        let imageView = UIImageView.getProfileFrame(with: ImageService.defaultPhotoString)
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    lazy var photoPicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        return imagePicker
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.appMainColor, for: .normal)
        button.setTitle("Upload photo", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleUploadPhoto), for: .touchUpInside)
        return button
    }()
    
    
    let divider1 = UIView.getDivider()
    let divider2 = UIView.getDivider()
    
    let textViewDescription: UITextView = {
        let textView = UITextView()
        textView.text = "This is optional, but uploading \n a picture will increase trust \n from other workers"
        textView.textColor = UIColor.darkGray
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    lazy var registerButton: UIButton = {
        let button = UIButton.getAppButton(text: "REGISTER")
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.addTarget(self, action: #selector(handleFinalize), for: .touchUpInside)
        return button
    }()
    
    
    let agreementParagraph = UITextView.getAgreement()
        
    private func setUpViews(){
        
        view.backgroundColor = UIColor.appEmptyColor
        
        view.addSubview(explainerLabel)
        view.addSubview(imageProfile)
        view.addSubview(divider1)
        view.addSubview(uploadButton)
        view.addSubview(divider2)
        view.addSubview(textViewDescription)
        view.addSubview(registerButton)
        view.addSubview(agreementParagraph)
        
        view.addConstrainsWithFormat(format: "V:[v0(30)]", views: explainerLabel)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: explainerLabel)
        explainerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        explainerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(120)]", views: imageProfile)
        view.addConstrainsWithFormat(format: "H:[v0(120)]", views: imageProfile)
        imageProfile.topAnchor.constraint(equalTo: explainerLabel.bottomAnchor, constant: 20).isActive = true
        imageProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider1)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        divider1.topAnchor.constraint(equalTo: uploadButton.topAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(50)]", views: uploadButton)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: uploadButton)
        uploadButton.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 20).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider2)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        divider2.topAnchor.constraint(equalTo: uploadButton.bottomAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(70)]", views: textViewDescription)
        view.addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: textViewDescription)
        textViewDescription.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 10).isActive = true
        textViewDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(42)]", views: registerButton)
        view.addConstrainsWithFormat(format: "H:|-60-[v0]-60-|", views: registerButton)
        registerButton.topAnchor.constraint(equalTo: textViewDescription.bottomAnchor, constant: 30).isActive = true
        
        view.addConstrainsWithFormat(format: "V:[v0(42)]", views: agreementParagraph)
        view.addConstrainsWithFormat(format: "H:|-60-[v0]-60-|", views: agreementParagraph)
        agreementParagraph.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20).isActive = true
        
  
    }
    
}

















