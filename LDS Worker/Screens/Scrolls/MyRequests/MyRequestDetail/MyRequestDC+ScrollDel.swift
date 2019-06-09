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
        let dimensionValue = scrollView.contentOffset.y < 0 ? 100 + (-scrollView.contentOffset.y) : 100
        myRequestDetailView.profileWidthConstraint?.constant = dimensionValue
        myRequestDetailView.profileHeightConstraint?.constant = dimensionValue
        myRequestDetailView.profilePicture.layer.cornerRadius = dimensionValue / 2
    }
}
