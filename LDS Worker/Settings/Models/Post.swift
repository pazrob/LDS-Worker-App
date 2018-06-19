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
    var author: UserProfile
    var note: String
    var from: String
    var to: String
    var timeStamp: Double
    var status: Bool
    
    init(id: String, author: UserProfile, note: String, from: String, to: String, timeStamp: Double, status: Bool) {
        self.id = id
        self.author = author
        self.note = note
        self.from = from
        self.to = to
        self.timeStamp = timeStamp
        self.status = status
    }
}
