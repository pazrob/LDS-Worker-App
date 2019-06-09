//
//  CollectionView+Extension.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func scrollToLast(withAnimation animation: Bool) {
    
        guard numberOfSections > 0 else { return }
        let lastSection = numberOfSections - 1
        guard numberOfItems(inSection: lastSection) > 0 else { return }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1, section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: animation ? true : false)
    }
    
//    func scrollToLatestText(withAnimation animation: Bool) {
//        if messages.count > 0 {
//            let indexPath = IndexPath(item: messages.count - 1 , section: 0)
//            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: animation ? true : false)
//        }
//    }
    
}
