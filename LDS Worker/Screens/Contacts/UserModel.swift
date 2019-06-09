

import UIKit

class UserModel {
    var photoURL : String?
    var firstName : String
    var lastName : String
    var fullName : String
    var uid : String
    var phone: String?
    var gender: String?
    
    init(photoURL: String?, firstName: String, lastName: String, uid: String, gender: String, phone: String?) {
        self.photoURL = photoURL
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(self.lastName), \(self.firstName)"
        self.uid = uid
        self.gender = gender
        self.phone = phone
    }
}
