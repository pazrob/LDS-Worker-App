//
//  ProfileViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/15/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let myArray = ["FIRST NAME:","LAST NAME:","EMAIL:", "TEMPLE:"]
    private var userInfo = [String]()
    private var userProfile: UserProfile?
    let profileCell = "profileCell"
    let headerProfileCell = "headerProfileCell"
    
    lazy var photoPicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        return imagePicker
    }()
    
    lazy var profileCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.appEmptyColor
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: profileCell)
        collection.register(HeaderProfileCell.self, forCellWithReuseIdentifier: headerProfileCell)
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.bounces = true
        return collection
    }()
    
    func fetchUserInfo() {
        if let userProfile = FirebaseService.currentUserProfile,
            let name = userProfile.firstName,
            let lastname = userProfile.lastName,
            let email = userProfile.email {
            
            userInfo.append(name)
            userInfo.append(lastname)
            userInfo.append(email)
            userInfo.append("My temple")
        } else {
            //Should dissmis the controller
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        fetchUserInfo()
        setUpNavigationItems()
        setUpViews()
    }
    
    private func setUpViews(){
        
        view.addSubview(profileCollection)             
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: profileCollection)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: profileCollection)
    }
    
    @IBAction func handleRefresh(_ sender: Any) {
        print("UPDATE PICTURE")
    }
    
    private func setUpNavigationItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(handleSave))
    }
    
    @objc func handleSave(){
        print("Do the saving")
        
        //Pops current viewController
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else {
            return myArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = profileCollection.dequeueReusableCell(withReuseIdentifier: headerProfileCell, for: indexPath) as! HeaderProfileCell
            cell.profileController = self
            cell.imageProfile.image = FirebaseService.userPhoto
            return cell
        } else {
            let cell = profileCollection.dequeueReusableCell(withReuseIdentifier: profileCell, for: indexPath) as! ProfileCell
            cell.descriptionLabel.text = myArray[indexPath.row]
            cell.textField.text = userInfo[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let touchedCell = collectionProfile.cellForRow(at: indexPath) as! ProfileCell
//        touchedCell.textField.becomeFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.profileCollection.frame.width, height: 250)
        } else {
            return CGSize(width: self.profileCollection.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func handleUploadImage(){
        print("Getting photo...")
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            FirebaseService.userPhoto = pickedImage.withRenderingMode(.alwaysOriginal)
            profileCollection.reloadData()
            handleUpload(with: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleUpload(with profilePicturePlaceholder: UIImage?){
        
        //Check if user uploaded a picture
        
        //1. Get picture from ImageView
        if let imageProfile = profilePicturePlaceholder {
            
            //2. Upload image to Firebase Storage
            FirebaseService.uploadProfilePicture(imageProfile) { url in
                if url != nil {
                    
                    //3. Save the profile info to Database
                    FirebaseService.updateUserProfile(profileImageURL: url!, completion: { success in
                        if success {
                            print("PICTURE UPLOADED TO DATABASE")
                        } else {
                            print("ERROR: Uploading link to database")
                        }
                    })
                }
            }
            
        } else {
            print("NO PICTURE UPLOADED")
        }
    }
}






















