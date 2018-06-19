//
//  ImageService.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DataService {
    
    static var userGroupPosts = [Post]()
    static var userPersonalPosts = [Post]()
    
    static func loadPosts(){
        
        let postRef = Database.database().reference().child("requests")
        //Observes all in posts in requests
        postRef.observe(DataEventType.value) { (datasnapshot) in
            
            var tempPost = [Post]()
            for child in datasnapshot.children {
                if let childSnapShot = child as? DataSnapshot,
                    let dict = childSnapShot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let email = author["email"] as? String,
                    let uid = author["uid"] as? String,
                    let firstName = author["firstName"] as? String,
                    let lastName = author["lastName"] as? String,
                    let note = dict["note"] as? String,
                    let from = dict["from"] as? String,
                    let to = dict["to"] as? String,
                    let timeStamp = dict["timestamp"] as? Double,
                    let status = dict["status"] as? Bool {
                    
                    let photoURL = author["photoURL"] as? String
                    let userProfile = UserProfile(uid: uid, firstName: firstName, lastName: lastName, email: email, imageURL: photoURL)
                    let post = Post(id: childSnapShot.key, author: userProfile, note: note, from: from, to: to, timeStamp: timeStamp, status: status)
                    tempPost.append(post)
                    
                }
            }
            filterPosts(with: tempPost)
        } //Observe finishes
    }
    
    static func filterPosts(with posts: [Post]?){
        guard let downloadedPosts = posts else { return }
        guard let user = FirebaseService.currentUserProfile else { return }
        for post in downloadedPosts {
            if user.uid == post.author.uid {
                self.userPersonalPosts.append(post)
            } else {
                self.userGroupPosts.append(post)
            }
        }
    }
    
}




