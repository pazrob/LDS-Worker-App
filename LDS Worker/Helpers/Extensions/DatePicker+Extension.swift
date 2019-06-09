//
//  DatePicker+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension UIDatePicker {
    
    static func getDatePicker() -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.minuteInterval = 10
        datePicker.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return datePicker
    }
    
}
