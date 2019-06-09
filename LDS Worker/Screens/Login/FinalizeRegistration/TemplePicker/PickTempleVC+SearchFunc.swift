//
//  PickTempleVC+SearchFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickTempleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        mainView.templeCollection.isHidden = false
        
        guard !searchText.isEmpty else {
            mainView.templeCollection.isHidden = true
            updateCollection(with: baseTemples)
            return
        }
        
        let searchedTemples = baseTemples.filter({ temple in
            temple.lowercased().contains(searchText.lowercased())
        })
        
        updateCollection(with: searchedTemples)
    }
    
    
    func updateCollection(with newArray: [String]) {
        filteredTemple = newArray
        mainView.templeCollection.reloadData()
    }
}
