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
    
    
    
    // Registers user
    static func performRegister(email: String,
                                password: String,
                                completion: @escaping ((_ success: Bool, _ errMessage: String?) -> ())){
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            
            if error == nil && user != nil {
                completion(true, nil)
            } else {
                completion(false, error?.localizedDescription)
            }
        }
    }
    
    
    //Saves user profile in database
    static func saveUserProfile(firstNameValue firstName: String,
                                lastNameValue lastName: String,
                                genderValue gender: String,
                                emailValue email: String,
                                temple: String,
                                photoUrl: String?,
                                completion: @escaping ((_ success: Bool) -> ())) {
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        let userObject = [
            NodeKeys.firstName.rawValue : firstName,
            NodeKeys.lastName.rawValue : lastName,
            NodeKeys.gender.rawValue : gender,
            NodeKeys.email.rawValue : email,
            NodeKeys.photoURL.rawValue : photoUrl as Any,
            NodeKeys.temple.rawValue : temple
            ] as [String:Any]
        
        let usersRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple).child(userId)
        usersRef.setValue(userObject) { error, _ in
            
            if error == nil {
                saveUserTemple(uid: userId, temple: temple, completion: { success in
                    completion(success)
                })
            } else {
                completion(false)
            }
        }
    }
    
    
    // Saves the temple on a new base node
    static func saveUserTemple(uid: String, temple: String, completion: @escaping ((_ success: Bool) -> ())){
        
        let userTempleObject = [uid:temple]
        
        let usersTemplesRef = Database.database().reference().child(BaseNodes.usersTemples.rawValue)
        usersTemplesRef.updateChildValues(userTempleObject) { (error, dataRef) in
            
            let success = error == nil
            completion(success)
        }
    }
    
    
    // Login User
    static func performLogin(email: String,
                             password: String,
                             completion: @escaping ((_ success: Bool,_ theError: Error?) -> ())){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                completion(true, nil)
            } else {
                completion(false, error!)
            }
        }
    }
    
    
    //Get user Profile
    static func fetchUserProfile(completion: @escaping (_ userProfile: UserProfile?) -> ()) {
       
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //Find out user's temple
        let userTempleRef = Database.database().reference().child(BaseNodes.usersTemples.rawValue).child(uid)
        userTempleRef.observeSingleEvent(of: .value) { userTempleSnap in
            
            //Fetch user Profile
            guard let temple = userTempleSnap.value as? String else {
                completion(nil)
                return
            }
            
            let userRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple).child(uid)
            userRef.observeSingleEvent(of: .value) { userSnap in
                
                let userProfile = fromSnapToUserProfile(snap: userSnap)
                completion(userProfile)
            }
        }
    }
    
    
    //Returns userProfile object from snap
    static func fromSnapToUserProfile(snap: DataSnapshot) -> UserProfile? {
        
        var userProfile: UserProfile?
        
        if let dict = snap.value as? [String:Any],
            
            let firstName = dict[NodeKeys.firstName.rawValue] as? String,
            let lastName = dict[NodeKeys.lastName.rawValue] as? String,
            let gender = dict[NodeKeys.gender.rawValue] as? String,
            let email = dict[NodeKeys.email.rawValue] as? String,
            let temple = dict[NodeKeys.temple.rawValue] as? String {
            
            let photoURL = dict[NodeKeys.photoURL.rawValue] as? String
            let phone = dict[NodeKeys.phone.rawValue] as? String
            userProfile = UserProfile(uid: snap.key,
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email,
                                      gender: gender,
                                      imageURL: photoURL,
                                      temple: temple,
                                      phone: phone)
        }
        
        return userProfile
    }
    
    static func updatePhoneNumber(phoneNumber: String, completion: @escaping ((_ success: Bool) -> ())){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        //1. Loading locations where the link ought to be updated
        var fanOutObject = [String : Any]()
        
        //User node to update with:
        fanOutObject["\(BaseNodes.users.rawValue)/\(temple)/\(uid)/\(NodeKeys.phone.rawValue)"] = phoneNumber
        
        //All previous requests
        let postsListRef = Database.database().reference().child(BaseNodes.usersRequest.rawValue).child(temple).child(uid)
        postsListRef.observeSingleEvent(of: .value) { postList in
            
            //3. If there is a userRequestSnap, load to object
            if let postsList = postList.value as? [String : Bool] {
                
                for postKey in postsList {
                    fanOutObject["\(BaseNodes.requests.rawValue)/\(temple)/\(postKey.key)/\(NodeKeys.phone.rawValue)"] = phoneNumber
                }
            }
            
            //4. Atomic Operation
            ImageService.performAtomicOperation(fanOutObject: fanOutObject, completion: { didSucceeded in
                completion(didSucceeded)
            })
        }
    }
    
    
    // Delete phone number
    static func deletePhoneNumber(completion: @escaping ((_ success:Bool) -> ())){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        //Erased from Storage, now delete references from database
        let databaseRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple).child("\(uid)/\(NodeKeys.phone.rawValue)")
        databaseRef.removeValue(completionBlock: { err, dataRef in
            
            if err != nil {
                completion(false)
            } else {
                //success
                FirebaseService.currentUserProfile?.phone = nil
                completion(true)
            }
        })
    }
    
    
    // Check is the app is bloqued
    static func isAppBloqued(completion: @escaping ((_ success:Bool) -> ())){
        
        //Network call
        let permissionRef = Database.database().reference().child(BaseNodes.permissions.rawValue)
        permissionRef.observeSingleEvent(of: .value, with: { dataSnap in
            
            //Check there is value
            guard let isBloqued = dataSnap.value as? Bool else {
                completion(false)
                return
            }
            
            //Return the bool
            completion(isBloqued)
            
        }) { err in
            //If there was an error
            completion(false)
        }
    }
    
    
    //Send verification Email
    static func sendVerificationEmail() {
        
        let user = Auth.auth().currentUser
        user?.sendEmailVerification(completion: nil)
    }
    
    
    //Recover Password
    static func sendPasswordRecoverEmail() {
        
        let user = Auth.auth()
        if let email = user.currentUser?.email {
            
            user.sendPasswordReset(withEmail: email, completion: nil)
        }
    }
    
    
    // Deletes the user on Authentication
    // ReAuthenticate must had been called before.
    static func deleteUserAccount(completion: @escaping ((_ success: Bool) -> ())){
        
        let user = Auth.auth().currentUser
        user?.delete { error in
            
            //If error is nil, there was success
            let result = error == nil
            completion(result)
        }
    }
    
    
    //Deletes from the user activity from database
    static func deleteUserTrace(uid: String, temple: String, completion: @escaping ((_ success: Bool) -> ())){
        
        var fanOutObject = [String : Any]()
        
        //Load all paths
        fanOutObject["\(BaseNodes.users.rawValue)/\(temple)/\(uid)"] = NSNull()
        
        //Load requests paths using personal array
        let myRequests = DataService.userPersonalPosts
        for requestAt in myRequests {
            let postId = requestAt.id
            fanOutObject["\(BaseNodes.requests.rawValue)/\(temple)/\(postId)"] = NSNull()
        }
        
        //Load users-temples node, requests-users
        fanOutObject["\(BaseNodes.usersTemples.rawValue)/\(uid)"] = NSNull()
        fanOutObject["\(BaseNodes.usersRequest.rawValue)/\(temple)/\(uid)"] = NSNull()
        
        //Delete with atomic operation
        let rootReference = Database.database().reference()
        rootReference.updateChildValues(fanOutObject) { error, data in
            
            //If error is nil, there was success
            let result = error == nil
            completion(result)
        }
    }
    
    
    //Re-Authenticate user before an important action
    static func reAuthenticate(password: String, completion: @escaping ((_ success: Bool,_ errorMessage: String?) -> ())){
        
        let user = Auth.auth().currentUser
        guard let email = user?.email else {
            completion(false, nil)
            return
        }
        var credential: AuthCredential
        
        // Prompt the user to re-provide their sign-in credentials
        credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        
        
        user?.reauthenticateAndRetrieveData(with: credential, completion: { authDataResult, error in
            if let error = error {
                // An error happened.
                completion(false, error.localizedDescription)
                
            } else {
                // User re-authenticated. Deleting.
                completion(true, nil)
            }
        })
    }
    
    
    // Oberseves users login state
    static func observeUserState() {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            //Logged in
            if user != nil {
                print("Logged in: OberserveUserState knows")
                //Logged out
            } else {
                //Clean all information on singletons and services
                FirebaseService.currentUserProfile = nil
                ImageService.userPhoto = nil
                MessageService.messageDictionary = [String:MessageModel]()
                print("Logged out: OberserveUserState knows")
            }
        }
    }
    
    
}
