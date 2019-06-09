//
//  Post.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/11/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation

class Post {
    var id: String
    var note: String
    var from: Double
    var to: String
    var timeStamp: Double
    var status: Bool
    
    //author remainder
    var uid: String
    var firstName: String
    var lastName: String
    var gender: String
    var imageURL: String?
    var phone: String?
    
    init(id: String, note: String, from: Double, to: String, timeStamp: Double, status: Bool,
        uid: String, firstName: String, lastName: String, gender: String, imageURL: String?, phone: String?) {
        self.id = id
        self.note = note
        self.from = from
        self.to = to
        self.timeStamp = timeStamp
        self.status = status
        
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.imageURL = imageURL
        self.phone = phone
    }
    
    func getFromString() -> String {
        
        let date = Date(timeIntervalSince1970: self.from)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "E, MMM d'    'h:mm a"
        return formatter.string(from: date)
    }
    
    func getGenderTitle() -> String {
        
        switch gender {
        case "m":
            return "Brother"
        case "f":
            return "Sister"
        default:
            return "-"
        }
    }
    
    func getGenderPhotoString() -> String {
        
        switch gender {
        case "m":
            return PictureKeys.brotherDefault.rawValue
        case "f":
            return PictureKeys.sisterDefault.rawValue
        default:
            return PictureKeys.brotherDefault.rawValue
        }
    }
}
