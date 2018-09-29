//
//  String+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 8/14/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension String {
    
    static func getNumberedFormated(phone: String) -> String {
        //Check that only digits
        //return if not
        
        var index = 0
        var phoneString = ""
        
        //Replicates the expected format
        for at in phone {
            if index == 0 {
                phoneString.append("(")
            }
            if index == 3 {
                phoneString.append(")")
            }
            if index == 6 {
                phoneString.append("-")
            }
            phoneString.append(at)
            index += 1
        }
        return phoneString
    }
    
    static func filterDigitsIntoString(from text: String) -> String {
        let numberArray = text.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return numberArray.joined(separator: "")
    }
}
