//
//  ContactsController+Search.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension ContactsController: UISearchResultsUpdating {
    
//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        guard !searchText.isEmpty else {
            self.filterWorkers(workers: baseWorkers)
            return
        }
        
        let workers = baseWorkers?.filter({ worker in
            worker.fullName.lowercased().contains(searchText.lowercased())
        })
        
        filterWorkers(workers: workers)
    }
}
