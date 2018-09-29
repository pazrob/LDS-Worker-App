//
//  RequestEdit.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


class RequestEdit {
    
    var note: String?
    var from: Double?
    var to: String?
    
    func getFromString() -> String {
        
        guard let fromTime = self.from else { return ""}
        
        let date = Date(timeIntervalSince1970: fromTime)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "E, MMM d'    'h:mm a"
        return formatter.string(from: date)
    }
}
