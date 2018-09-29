//
//  ContactsController+SortingFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension ContactsController {
    
    func filterWorkers(workers: [UserModel]?) {
        
        if let rawWorkers = workers {
            
            filteredWorkers.removeAll()
            for worker in rawWorkers {
                
                guard !worker.lastName.isEmpty else { continue }
                
                let index = worker.lastName.index(worker.lastName.startIndex, offsetBy: 0)
                let initialCharacter = worker.lastName[index]
                
                if filteredWorkers.keys.contains(initialCharacter), var workersIn = filteredWorkers[initialCharacter] {
                    workersIn.append(worker)
                    filteredWorkers.updateValue(workersIn, forKey: initialCharacter)
                } else {
                    filteredWorkers[initialCharacter] = [worker]
                }
                
            }
            sortedWorkers = filteredWorkers.sorted { (a0, b0) -> Bool in
                return a0.0 < b0.0
            }
            
            self.collectionView?.reloadData()
        }
    }
    
    func fetchWorkers() {
        
        //Check if baseWorkers has users
        if let workers = baseWorkers, !workers.isEmpty {
            return
        }
        
        DataService.fetchUsers { users in
            self.filterWorkers(workers: users)
            self.baseWorkers = users
        }
    }
}
