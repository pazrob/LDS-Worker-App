//
//  ImageService.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class DataService {
    
    static var userGroupPosts = [Post]() {
        
        didSet{
            
            //Sort array by timestamps (from lowest to highest)
            userGroupPosts = sortLowToHigh(array: userGroupPosts)
            
            //Send notification when array has changed
            NotificationCenter.default.post(name: NSNotification.Name.groupRequestKey, object: nil)
        }
    }
    
    static var userPersonalPosts = [Post]() {
        
        didSet{
            
            // Sort array by timestamps (from lowest to highest)
            userPersonalPosts = sortLowToHigh(array: userPersonalPosts)
            
            // Send notification when array has changed
            NotificationCenter.default.post(name: NSNotification.Name.personalRequestKey, object: nil)
        }
    }
    
    // Sort array based on timestamp from lowest to highest
    static func sortLowToHigh(array: [Post]) -> [Post] {
        
        var sortedArray = array
        
        sortedArray.sort(by: { message1, message2 -> Bool in
            let timestamp1 = message1.from
            let timestamp2 = message2.from
            
            return (timestamp1) < (timestamp2)
        })
        
        return sortedArray
    }
    
    // Firebase references
    let dataRef = Database.database().reference()
    	
 
    // Fetch up to 15 requests from firebase. These requests are the most current.
    // Set up private observers for change and remove posts.
    static func fetchTemplePosts(){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        //Get current date into timestamp
        let currentDate = Calendar.current.startOfDay(for: Date())
        let todayTimestamp: Double = currentDate.timeIntervalSince1970
        
        //Fetch ordered by key:from, starting today, get 15 max
        let postRef = Database.database().reference()
            .child(BaseNodes.requests.rawValue)
            .child(temple)
            .queryOrdered(byChild: NodeKeys.from.rawValue)
            .queryStarting(atValue: todayTimestamp)
            .queryLimited(toFirst: 15)
        
        postRef.observe( .childAdded) { requestSnap in
            
            //Create the post from snap
            guard let post = self.getPostFromSnap(snap: requestSnap) else { return }
            
            //Return if the request is already on any array
            //This will prevent observing change and removed twice
            if userGroupPosts.contains(where: { return $0.id == post.id }) {
                return
            }
            
            //Prevent from observing or adding yourself
            if post.uid == uid {
                return
            }
            
            //Observe posts
            self.observeRequestChanged(requestID: post.id)
            self.observeRequestRemoved(RequestID: post.id)
            
            //Append to group posts array
            userGroupPosts.append(post)
        }
    }
    
    
    // Fetch up to 10 requests from firebase. These are all the user's requests.
    static func fetchPersonalPosts(){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else {  return }
        
        //Fetch ordered by key:from, starting today, get 15 max
        let pastaR = Database.database().reference()
            .child(BaseNodes.requests.rawValue)
            .child(temple)
            .queryOrdered(byChild: NodeKeys.uid.rawValue)
            .queryEqual(toValue: uid)
        
        pastaR.observeSingleEvent(of: .value) { requestSnap in
            
            var newPosts = [Post]()
            
            for snap in requestSnap.children {
                
                guard let newSnap = snap as? DataSnapshot else { return }
                
                //Create the post from snap
                guard let post = self.getPostFromSnap(snap: newSnap) else { return }
                newPosts.append(post)
            }
            
            //Append to group posts array
            userPersonalPosts = newPosts
            
        }
    }
    
    
    //  Oberve changes on request.
    static func observeRequestChanged(requestID: String) {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        
        let requestRef = Database.database().reference()
            .child(BaseNodes.requests.rawValue)
            .child(temple)
            .child(requestID)
        
        requestRef.observe( .childChanged, with: { requestSnap in
            
            print("CHANGE: \(requestSnap)")
            let key = requestSnap.key
            let value = requestSnap.value
            var index: Int = 0
            
            //Update local array
            for p in userGroupPosts {
                
                if requestID == p.id {
                    let postInChange = userGroupPosts[index]
                    
                    if updatePost(with: key, value: value, post: postInChange) {
                        userGroupPosts[index] = postInChange
                    }
                    return
                }
                index += 1
            }
        })
    }
    
    
    // Observe deletion on request.
    static func observeRequestRemoved(RequestID: String) {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        
        //Observes is uid key is removed
        let requestRef = Database.database().reference()
            .child(BaseNodes.requests.rawValue)
            .child(temple)
            .child(RequestID)
            .queryOrderedByKey()
            .queryLimited(toLast: 1) //This works because uid key is at last
        
        requestRef.observe( .childRemoved, with: { uidSnap in
            
            guard let authorID = uidSnap.value as? String else { return }
            
            //Remove post from any array
            removePostFromArray(with: authorID, postId: RequestID)
        })
    }
    
    
    // Remove post if found on personal and temple array
    static func removePostFromArray(with authorID: String, postId: String) {
        
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        var index = 0
        
        //It's in personalPosts
        if uid == authorID {
            for p in userPersonalPosts {
                if p.id == postId {
                    userPersonalPosts.remove(at: index)
                }
                index += 1
            }
            return
        }
        
        //It's in groupPosts
        for p in userGroupPosts {
            if p.id == postId {
                userGroupPosts.remove(at: index)
            }
            index += 1
        }
    }
    
    
    // Update post with key and value.
    static func updatePost(with key: String, value: Any?, post: Post) -> Bool {
        
        switch key {
            
        case NodeKeys.note.rawValue:
            if let note = value as? String {
                post.note = note
                return true
            }
        case NodeKeys.from.rawValue:
            if let from = value as? Double {
                post.from = from
                return true
            }
            
        case NodeKeys.to.rawValue:
            if let to = value as? String {
                post.to = to
                return true
            }
        case NodeKeys.status.rawValue:
            if let status = value as? Bool {
                post.status = status
                return true
            }
        case NodeKeys.phone.rawValue:
            if let phone = value as? String {
                post.phone = phone
                return true
            }
            
        case NodeKeys.photoURL.rawValue:
            //Update only if it is your photo
            //This save downloads
            if post.uid == FirebaseService.currentUserProfile?.uid {
                
                if let url = value as? String {
                    post.imageURL = url
                    return true
                }
            }
    
        default:
            print("Something else was changed")
        }
        
        return false
    }
    
    
    // Convers a proper snap into post object. Can return nil
    static func getPostFromSnap(snap: DataSnapshot) -> Post? {
        
        var post: Post?
        
        if let dict = snap.value as? [String:Any],
            let uid = dict[NodeKeys.uid.rawValue] as? String,
            let firstName = dict[NodeKeys.firstName.rawValue] as? String,
            let lastName = dict[NodeKeys.lastName.rawValue] as? String,
            let gender = dict[NodeKeys.gender.rawValue] as? String,
            let note = dict[NodeKeys.note.rawValue] as? String,
            let from = dict[NodeKeys.from.rawValue] as? Double,
            let to = dict[NodeKeys.to.rawValue] as? String,
            let timeStamp = dict[NodeKeys.timestamp.rawValue] as? Double,
            let status = dict[NodeKeys.status.rawValue] as? Bool,
            let phone = dict[NodeKeys.phone.rawValue] as? String {
            
            //photo is optional
            let photoURL = dict[NodeKeys.photoURL.rawValue] as? String
            
            //Load post
            post =  Post(id: snap.key, note: note, from: from, to: to, timeStamp: timeStamp, status: status,
                         uid: uid, firstName: firstName, lastName: lastName, gender: gender, imageURL: photoURL, phone: phone)
        }
        
        return post
    }
    
    
    // Deletes a post that matches postId
    static func deletePost(with postId: String) {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        //Network call
        let postRef = Database.database().reference().child(BaseNodes.requests.rawValue).child(temple).child(postId)
        let userRequestRef = Database.database().reference().child(BaseNodes.usersRequest.rawValue).child(temple).child(uid).child(postId)
        postRef.removeValue()
        userRequestRef.removeValue()
        
        //Delete locally for personal posts
        var index: Int = 0
        for post in userPersonalPosts {
            if post.id == postId {
                userPersonalPosts.remove(at: index)
                return
            }
            index += 1
        }
    }
    
    // Updates post status only
    static func updatePostStatus(with postId: String, status: Bool) {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        
        //To send
        let updatePost = [NodeKeys.status.rawValue : status]
        
        //Connect to Firebase
        let postRef = Database.database().reference().child(BaseNodes.requests.rawValue).child(temple).child(postId)
        postRef.updateChildValues(updatePost)
        
        //Update locally for personal posts
        var index: Int = 0
        for post in userPersonalPosts {
            if post.id == postId {
                let postInChange = userPersonalPosts.remove(at: index)
                postInChange.status = status
                userPersonalPosts.insert(postInChange, at: index)
                return
            }
            index += 1
        }
    }
    
    
    // Updates post: note, from or to.
    static func updateEditedPost(with postId: String, note: String, from: Double, to: String) {
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        
        //Connect to Firebase
        let postRef = Database.database().reference().child(BaseNodes.requests.rawValue).child(temple).child(postId)
        let updatePost = [
            NodeKeys.note.rawValue : note,
            NodeKeys.from.rawValue : from,
            NodeKeys.to.rawValue : to
            ] as [String:Any]
        
        postRef.updateChildValues(updatePost)
        
        //Update locally for personal posts
        var index: Int = 0
        for post in userPersonalPosts {
            if post.id == postId {
                let postInChange = userPersonalPosts.remove(at: index)
                postInChange.note = note
                postInChange.from = from
                postInChange.to = to
                userPersonalPosts.insert(postInChange, at: index)
            }
            index += 1
        }
    }
    
    
    // Fetch all temple users information
    static func fetchUsers(completion: @escaping(_ users: [UserModel]) -> ()){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        //Connect to Firebase
        let usersRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple)
        usersRef.observeSingleEvent(of: .value) { usersSnap in
            
            var contacts =  [UserModel]()
            
            for userAny in usersSnap.children {
                
                if let userSnap = userAny as? DataSnapshot {
                    
                    //Get user from snap
                    if let newUser = getUserFromSnap(snap: userSnap) {
                        
                        //Skip if it's me
                        if newUser.uid == uid { continue }
                        
                        //Append to array
                        contacts.append(newUser)
                    }
                }
            }
            
            completion(contacts)
        }
    }
    
    
    // Get UserModel object from snap. Can return nil.
    static func getUserFromSnap(snap: DataSnapshot) -> UserModel? {
        
        // From snap to model
        var userResult : UserModel?
        let userID = snap.key
        
        if let dict = snap.value as? [String:Any],
            
            let name = dict[NodeKeys.firstName.rawValue] as? String,
            let last = dict[NodeKeys.lastName.rawValue] as? String,
            let gender = dict[NodeKeys.gender.rawValue] as? String {
            
            //Photo optional
            let photoUrl = dict[NodeKeys.photoURL.rawValue] as? String
            
            //Phone optional
            let phone = dict[NodeKeys.phone.rawValue] as? String
            
            //Load user
            userResult = UserModel(photoURL: photoUrl, firstName: name, lastName: last, uid: userID, gender: gender, phone: phone)
        }
        
        return userResult
    }
    
    
    // Connects to Firebase database and performs to saving actions:
    // 1. Saves the request and the user information that created it into a request node.
    // 2. Saves the userId and the requestId into a user-request node.
    static func performSendRequest(note: String, from: Double, to: String, completion: @escaping(_ success: Bool) -> ()){
        
        guard let userProfile = FirebaseService.currentUserProfile else { return }
        let timestamp = Int64(Date().timeIntervalSince1970)
        
        let requestObject = [
            
            // Get user's info
            NodeKeys.uid.rawValue : userProfile.uid,
            NodeKeys.firstName.rawValue : userProfile.firstName,
            NodeKeys.lastName.rawValue : userProfile.lastName,
            NodeKeys.photoURL.rawValue : userProfile.imageURL as Any,
            NodeKeys.gender.rawValue : userProfile.gender,
            NodeKeys.phone.rawValue : userProfile.phone as Any,
            
            //Get post info
            NodeKeys.note.rawValue : note,
            NodeKeys.timestamp.rawValue : timestamp,
            NodeKeys.from.rawValue : from,
            NodeKeys.to.rawValue : to,
            NodeKeys.status.rawValue : false
            ] as [String : Any?]
        
        // 1. Saving request to "root:requests:userTemple:requestId:VALUE"
        let postRef = Database.database().reference().child(BaseNodes.requests.rawValue).child(userProfile.temple).childByAutoId()
        postRef.setValue(requestObject) { err, dataRef in
            
            if let error = err {
                
                // Return false
                print("Error in performSendRequest: \(error.localizedDescription)")
                completion(false)
                
            } else {
                
                guard let postId = postRef.key else { return }
                // 2. Saving request-id to users-requests node
                self.saveUserRequestFanOut(userId: userProfile.uid, requestId: postId, completion: { success in
                    
                    if !success {
                        completion(false)
                    }
                    
                    //Update locally for personal posts
                    let post = Post(id: postId, note: note, from: from, to: to, timeStamp: Double(timestamp), status: false, uid: userProfile.uid, firstName: userProfile.firstName, lastName: userProfile.lastName, gender: userProfile.gender, imageURL: userProfile.imageURL, phone: userProfile.phone)
                    userPersonalPosts.append(post)
                    
                    //Return result
                    completion(success)
                })
            }
        }
    }
    
    
    // Saves a fanout of send request operation
    static func saveUserRequestFanOut(userId: String, requestId: String, completion: @escaping(_ success: Bool) -> ()){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }

        let userPost = Database.database().reference().child(BaseNodes.usersRequest.rawValue).child(temple).child(uid)
        let newObject = [ requestId : 1] as [String : Int]
        userPost.updateChildValues(newObject, withCompletionBlock: { err, dataRef in
            
            if let error = err {
                
                //Return false
                print("Error in saveUserRequestFanOut: \(error.localizedDescription)")
                completion(false)
                
            } else {
                
                //Return success
                completion(true)
            }
        })
    }
}
