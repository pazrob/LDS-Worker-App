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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    let profilePicturePlaceholder: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "uploadPhotoIcon")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 150/2
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var skipLabel: UILabel = {
        let label = UILabel()
        label.text = "Next"
        label.textColor = UIColor.rgb(red: 0, green: 122, blue: 255)
        label.font = label.font.withSize(16)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSkip)))
        return label
    }()
    
    let explainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Add your Photo"
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        return label
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
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "uploadButtonIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 6)
        button.addTarget(self, action: #selector(handleUploadPhoto), for: .touchUpInside)
        return button
    }()
    @objc func handleUploadPhoto(){
        print("Getting photo...")
        self.present(photoPicker, animated: true, completion: nil)
    }
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setUpViews(){
        view.backgroundColor = UIColor.appEmptyColor
        
        view.addSubview(skipLabel)
        view.addSubview(profilePicturePlaceholder)
        view.addSubview(uploadButton)
        view.addSubview(explainerLabel)
        
        view.addConstrainsWithFormat(format: "V:|-40-[v0]", views: skipLabel)
        view.addConstrainsWithFormat(format: "H:[v0]-20-|", views: skipLabel)
        
        
        view.addConstrainsWithFormat(format: "V:|-50-[v0(150)]", views: profilePicturePlaceholder)
        view.addConstrainsWithFormat(format: "H:[v0(150)]", views: profilePicturePlaceholder)
        view.addConstraint(NSLayoutConstraint(item: profilePicturePlaceholder, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstrainsWithFormat(format: "V:[v0(130)]", views: uploadButton)
        view.addConstrainsWithFormat(format: "H:[v0(130)]", views: uploadButton)
        view.addConstraint(NSLayoutConstraint(item: uploadButton, attribute: .centerX, relatedBy: .equal, toItem: profilePicturePlaceholder, attribute: .centerX, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: uploadButton, attribute: .centerY, relatedBy: .equal, toItem: profilePicturePlaceholder, attribute: .centerY, multiplier: 1, constant: 55))
        
        view.addConstrainsWithFormat(format: "V:[v0]", views: explainerLabel)
        view.addConstrainsWithFormat(format: "H:[v0]", views: explainerLabel)
        view.addConstraint(NSLayoutConstraint(item: explainerLabel, attribute: .top, relatedBy: .equal, toItem: profilePicturePlaceholder, attribute: .bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: explainerLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 10))
        
    }
    
    @objc func handleSkip(){
        
        //Check if user uploaded a picture
        
        //1. Get picture from ImageView
        if let imageProfile = profilePicturePlaceholder.image {
            
            //2. Upload image to Firebase Storage
            FirebaseService.uploadProfilePicture(imageProfile) { url in
                if url != nil {
                    
                    //3. Save the profile info to Database
                    FirebaseService.updateUserProfile(profileImageURL: url!, completion: { success in
                        if success {
                            print("PICTURE UPLOADED TO DATABASE")
                            let layout = UICollectionViewFlowLayout()
                            self.navigationController?.pushViewController(HomeController(collectionViewLayout: layout), animated: true)
                        }
                    })
                }
            }
            
        } else {
            print("NO PICTURE UPLOADED")
            let layout = UICollectionViewFlowLayout()
            self.navigationController?.pushViewController(HomeController(collectionViewLayout: layout), animated: true)
        }
    }
    
    
    var registeredUserId: String?    
    
}
extension PickPhotoViewController :  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profilePicturePlaceholder.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
}















