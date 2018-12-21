//
//  ImageService.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class ImageService {
    
    static var userPhoto: UIImage?
    static var defaultPhotoString = PictureKeys.brotherDefault.rawValue
    static let cache = NSCache<NSString, UIImage>()
    
    
    
    //Dowload an image with link
    static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()){
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            
            //If fails
            if error != nil || data == nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            //If Success
            if let dataIn = data, let downloadedImage = UIImage(data: dataIn) {
                
                //Cache image
                cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                
                //Send completion
                DispatchQueue.main.async {
                    completion(downloadedImage)
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    // Checks image in cache, downloads otherwise
    static func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()){
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                print("\n > A. Getting cache: \n", url)
                completion(image)
            }
            
        } else {
            print("\n > B. DOWNLOADING: \n", url)
            downloadImage(withURL: url, completion: completion)
        }
    }
    
    
    // Fetch current users photo
    static func loadUserPicture(gender: String?){
        
        guard let currentUser = FirebaseService.currentUserProfile else {return}
        
        if let urlString = currentUser.imageURL, let imageURL = URL(string: urlString) {
            
            ImageService.getImage(withURL: imageURL) { (userPhoto) in
                self.userPhoto = userPhoto
            }
            
        } else {
            //Assign default photo based on gender
            ImageService.userPhoto = nil
        }
    }
    
    
    //Uploads users picture to storage
    static func uploadPhotoToStorage(_ picture: UIImage, completion: @escaping ((_ url:URL?) -> ())){
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let imageData = picture.jpegData(compressionQuality: 0.25) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let storageRef = Storage.storage().reference().child(StorageKeys.user.rawValue).child(userId)
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            
            //success
            if error == nil, metaData != nil {
                
                storageRef.downloadURL(completion: { url, error in
                    
                    //Cannot download
                    guard error == nil && url != nil else {
                        print(error!.localizedDescription)
                        completion(nil)
                        return
                    }
                    
                    //Return the url, or nil if no url
                    DispatchQueue.main.async {
                        
                        //Cache image
                        cache.setObject(picture, forKey: url!.absoluteString as NSString)
                        completion(url)
                    }
                })
                
            } else {
                //failed
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    
    static func deletePhotoFromStorage(uid: String){
        
        let pictureRef = Storage.storage().reference().child(StorageKeys.user.rawValue).child(uid)
        pictureRef.delete(completion: nil)
    }
    
    
    static func handleDeleteImage(completion: @escaping ((_ success:Bool) -> ())){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        guard let uid = FirebaseService.currentUserProfile?.uid else { return }
        
        let storageRef = Storage.storage().reference().child(StorageKeys.user.rawValue).child(uid)
        storageRef.delete { err in
            if err != nil {
                //Not erased from Storage
                print("Error in delete.")
                completion(false)
                
            } else {
                
                //Erased from Storage, now delete references from database
                let databaseRef = Database.database().reference().child(BaseNodes.users.rawValue).child(temple).child("\(uid)/\(NodeKeys.photoURL.rawValue)")
                databaseRef.removeValue(completionBlock: { err, dataRef in
                    
                    if err != nil {
                        completion(false)
                        
                    } else {
                        //success
                        DispatchQueue.main.async {
                            FirebaseService.currentUserProfile?.imageURL = nil
                            ImageService.userPhoto = nil
                            completion(true)
                        }
                    }
                })
            }
        }
    }
    
    
    static func updatePhotoInDatabase(profileImageURL: URL, completion: @escaping ((_ success: Bool) -> ())){
        
        guard let temple = FirebaseService.currentUserProfile?.temple else { return }
        
        //1. Get root Reference and create fanout object
        guard let userId = Auth.auth().currentUser?.uid else { return }
        var fanOutObject = [String : Any]()
        
        //2. Load user node
        fanOutObject["\(BaseNodes.users.rawValue)/\(temple)/\(userId)/\(NodeKeys.photoURL.rawValue)"] = profileImageURL.absoluteString
        
        //3. Fetch users-requests locations
        let userRequestRef = Database.database().reference().child("\(BaseNodes.usersRequest.rawValue)/\(temple)").child(userId)
        userRequestRef.observeSingleEvent(of: DataEventType.value, with: { userRequestSnap in

            
            //3. If there is a userRequestSnap, load to object
            if let requestsKeys = userRequestSnap.value as? [String : Bool] {
                
                for key in requestsKeys {
                    fanOutObject["\(BaseNodes.requests.rawValue)/\(temple)/\(key.key)/\(NodeKeys.photoURL.rawValue)"] = profileImageURL.absoluteString
                }
            }
            
            //4. Atomic Operation
            performAtomicOperation(fanOutObject: fanOutObject, completion: { didSucceeded in
                completion(didSucceeded)
            })
            
        })
    }
    
    static func performAtomicOperation(fanOutObject: [String : Any], completion: @escaping ((_ success: Bool) -> ())){
        
        let rootReference = Database.database().reference()
        rootReference.updateChildValues(fanOutObject) { (error, dataRef) in
            
            let succeeded = error == nil
            completion( succeeded )
        }
    }
}
