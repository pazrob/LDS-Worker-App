

import Foundation
import UIKit

class MessageModel{
    var toId: String?
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var senderPicture: UIImage?
    
    init(dictionary: [String : Any]) {
        self.toId = dictionary["toId"] as? String
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
    
    private func setSenderPicture(with photo: UIImage){
        self.senderPicture = photo
    }
    
    public func getChatReceipientUID() -> String?{
        return (self.fromId == FirebaseService.currentUserProfile?.uid) ? toId : fromId
    }
    
}
