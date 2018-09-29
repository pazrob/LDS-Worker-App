//
//  MyRequestDC+3.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension MyRequestDetailController: UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            let dimensionValue = 100 + (-scrollView.contentOffset.y)
            myRequestDetailView.profilePicture.layer.cornerRadius = dimensionValue / 2
            myRequestDetailView.profileWidthConstraint?.constant = dimensionValue
            myRequestDetailView.profileHeightConstraint?.constant = dimensionValue
        }
        
    }
    
    
}
