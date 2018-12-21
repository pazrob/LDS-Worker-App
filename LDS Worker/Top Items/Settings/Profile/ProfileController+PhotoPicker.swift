//
//  ProfileController+PhotoPicker.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func handleUploadImage(){
        photoPicker.delegate = self
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func handleDeleteImage(){
        
        ImageService.handleDeleteImage { (success) in
            if success {
                self.profileCollection.reloadData()
            } else {
                print("There has been an error")
            }
        }
    }
    
    
    //Gets the image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            uploadPhoto(with: selectedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Upload photo to storage and database
    func uploadPhoto(with selectedImage: UIImage?){
        
        //1. Get selected image
        if let imageProfile = selectedImage {
            
            //2. Upload image to Firebase Storage
            ImageService.uploadPhotoToStorage(imageProfile) { url in
                guard url != nil else {
                    print("Url from Storage came nil")
                    return
                }
                
                //3. Update photo-url in Database
                ImageService.updatePhotoInDatabase(profileImageURL: url!, completion: { success in
                    if success {
                        FirebaseService.currentUserProfile?.imageURL = url?.absoluteString
                        ImageService.userPhoto = imageProfile.withRenderingMode(.alwaysOriginal)
                        self.profileCollection.reloadData()
                        
                    } else {
                        print("ERROR: Uploading link to database")
                    }
                })
                
            }
            
        } else {
            print("NO PICTURE UPLOADED")
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
