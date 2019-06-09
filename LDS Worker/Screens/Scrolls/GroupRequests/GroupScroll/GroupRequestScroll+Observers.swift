//
//  GroupRequestScroll+Observers.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/9/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension GroupRequestsVC {
    
    func addDataListener() {
        //make sure the queue is main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.groupRequestKey, object: nil, queue: nil) { notification in
            self.getPosts()
            self.groupRequestCollection.reloadData()
        }
    }
}
