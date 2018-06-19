//
//  ApiService.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/7/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class FirebaseService: NSObject {
    
    static var currentUserProfile : UserProfile?
    static var userPhoto = UIImage(named: "defaultPortrait")
    static var registeringAccount : Bool?
    
    static func saveUserProfile(firstNameValue firstName: String, lastNameValue lastName: String, emailValue email: String, completion: @escaping ((_ success: Bool) -> ())){
        print("Saving user to database...")
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(userId)")
        
        let userObject = [
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { (error, databaseReference) in
            let booleanTransaction = (error == nil)
            completion(booleanTransaction)
        }
    }
    
    static func performRegister(email: String, password: String, completion: @escaping ((_ success: Bool) -> ())){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            //1. Add user to auth
            if error == nil && user != nil {
                completion(true)
            } else {
                print("Error creating a user: \(error!.localizedDescription)")
                completion(false)
            }
        }
    }
    
    static func performLogin(email: String, password: String, completion: @escaping ((_ success: Bool,_ theError: Error?) -> ())){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                completion(true, nil)
            } else {
                print("Error loging in: \(error!.localizedDescription)")
                completion(false, error!)
            }
        }
    }
    
    static func uploadProfilePicture(_ picture: UIImage, completion: @escaping ((_ url:URL?) -> ())){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(userId)")
        guard let imageData = UIImageJPEGRepresentation(picture, 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                //success!
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                        return
                    }
                    if url != nil {
                        completion(url)
                    }
                })
                
            } else {
                //failed
                completion(nil)
            }
        }
    }
    
    static func updateUserProfile(profileImageURL: URL, completion: @escaping ((_ success: Bool) -> ())){
        print("updating profile...")
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(userId)")
        
        let userObject = [
            "photoURL" : profileImageURL.absoluteString,
            "temple" : "Inser Temple Here"
            ] as [String:Any]
        
        databaseRef.updateChildValues(userObject)
        completion(true)
    }
    
    static func performSendRequest(note: String, from: String, to: String){
        let postRef = Database.database().reference().child("requests").childByAutoId()
        
        guard let userProfile = FirebaseService.currentUserProfile else { return }
        
        let requestObject = [
            "author" : [
                "uid" : userProfile.uid,
                "email" : userProfile.email,
                "firstName" : userProfile.firstName,
                "lastName" : userProfile.lastName,
                "photoURL" : userProfile.imageURL,
            ],
            "note" : note,
            "timestamp" : [".sv": "timestamp" ],
            "from" : from,
            "to" : to,
            "status" : false
        ] as [String : Any]
        
        postRef.setValue(requestObject)
    }
    
    static func observeUserProfile(_ uid: String, completion: @escaping (_ userProfile: UserProfile?) -> () ) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        userRef.observe(DataEventType.value) { (snapshot) in
            var userProfile: UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
            let email = dict["email"] as? String,
            let firstName = dict["firstName"] as? String,
            let lastName = dict["lastName"] as? String {
                let photoURL = dict["photoURL"] as? String
                userProfile = UserProfile(uid: snapshot.key, firstName: firstName, lastName: lastName, email: email, imageURL: photoURL)
            }
            completion(userProfile)
        }
    }   

    
    
}



















