//
//  MyRequestScroll+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestScroll {
    
    func addDataListener() {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.personalRequestKey, object: nil, queue: OperationQueue.main) { notification in
            self.getRequests()
            self.myrequestCollectionView.reloadData()
        }
    }
    
}
