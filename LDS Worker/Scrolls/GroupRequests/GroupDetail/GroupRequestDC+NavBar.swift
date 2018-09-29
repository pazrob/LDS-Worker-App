//
//  GroupRequestDC+NavBar.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension GroupRequestDetailController {
    
    func setUpNavigationBar(){
        //Title Attributes
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Temple Requests"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
    }
}
