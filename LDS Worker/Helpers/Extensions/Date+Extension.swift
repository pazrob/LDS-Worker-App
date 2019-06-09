//
//  Date+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension Date {
    
    static func getTimeStamp(with seconds: Double) -> String {
        
        //Get the gap from the timestamp and present
        let gapFromPresent = Int(Date().timeIntervalSince1970) - Int(seconds)
        
        //If text is older than a week
        if gapFromPresent > 604800 {
            
            let timestampDate = Date(timeIntervalSince1970: seconds)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "MMM-d"
            return dateFormater.string(from: timestampDate)
        }
        
        //If text is older than a day
        if gapFromPresent > 86400 {
            
            let timestampDate = Date(timeIntervalSince1970: seconds)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "E"
            return dateFormater.string(from: timestampDate)
        }
        
        //If text is younger than a minute
        //FIX: There is no update after 60 secs automaticly
        if gapFromPresent < 20 {
            return "Just Now"
        }
        
        //If text is between 60 sec and a day
        let timestampDate = Date(timeIntervalSince1970: seconds)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        return dateFormater.string(from: timestampDate)
    }
    
    static func getStartOfDay(from timestamp: TimeInterval) -> TimeInterval {
        
        //Get the date from timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        
        //Return timestamp from startOfDay
        return Calendar.current.startOfDay(for: date).timeIntervalSince1970
    }
    
    static func getStringDate(with seconds: Double) -> String {
        
        //Get the date
        let date = Date(timeIntervalSince1970: seconds)
        
        //Set format
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE, MMM d"
        return dateFormater.string(from: date)
    }
    
    static func getStringTime(with seconds: Double) -> String {
        
        //Get the date
        let date = Date(timeIntervalSince1970: seconds)
        
        //Set format
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        return dateFormater.string(from: date)
    }
    
}
