//
//  Extensions.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/4/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let appMainColor = UIColor.rgb(red: 7, green: 165, blue: 165)
    static let appHightLightColor = UIColor.rgb(red: 18, green: 198, blue: 193)
    static let appOpaqueColor = UIColor.rgb(red: 7, green: 107, blue: 107)
    static let appEmptyColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    static let appDarkGray = rgb(red: 100, green: 100, blue: 100)
    static let appLightGray = UIColor.rgb(red: 230, green: 230, blue: 230)
    static let appMenuColor = UIColor.rgb(red: 7, green: 165, blue: 165)
    static let appLineColor = UIColor.rgb(red: 7, green: 132, blue: 128)
    static let appUncovered = UIColor.rgb(red: 163, green: 8, blue: 8)
    static let appBarStatus = UIColor.rgb(red: 7, green: 140, blue: 140)
    static let headerFooter = UIColor.rgb(red: 80, green: 80, blue: 80)
    static let appDivider = UIColor.rgb(red: 200, green: 200, blue: 200)
    
    static let appPeach = UIColor.rgb(red: 250, green: 124, blue: 106)
    static let bottomGradient = UIColor.rgb(red: 0, green: 174, blue: 145)
    
    static let fieldIcon = UIColor.rgb(red: 220, green: 220, blue: 220)
    
    static let appScrollBackground = UIColor.appEmptyColor
    
    static let sisterColor = UIColor.rgb(red: 252, green: 127, blue: 156)
    static let brotherColor = UIColor.appMainColor
}














