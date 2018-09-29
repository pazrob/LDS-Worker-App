//
//  UIActivity+Extension.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/22/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UIActivityViewController {
    
    static func inviteAFriend(viewController: UIViewController) {
        
        let activityVC = UIActivityViewController(activityItems: [UITextSettings.inviteFriendText.rawValue], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = viewController.view
        viewController.present(activityVC, animated: true, completion: nil)
    }
}
