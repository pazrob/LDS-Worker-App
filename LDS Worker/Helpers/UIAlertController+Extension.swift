//
//  UIAlertController.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func somethingWentWrongController (viewController: UIViewController?,
                                                title: String = "There has been an error, please try again later",
                                                preferredStyle: UIAlertControllerStyle = .alert) {
    
        let errorActionSheet = UIAlertController(title: title, message: nil, preferredStyle: preferredStyle)
        let actionOkay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
        errorActionSheet.addAction(actionOkay)
        
        viewController?.present(errorActionSheet, animated: true, completion: nil)
    }
    
    static func sendMessage(viewController: UIViewController? ,
                            title: String = "Error" ,
                            message: String,
                            preferredStyle: UIAlertControllerStyle = .alert) {
        
        guard let controller = viewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okay = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okay)
        
        controller.present(alert, animated: true, completion: nil)
    }

    

    
    
}
