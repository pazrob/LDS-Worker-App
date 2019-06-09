//
//  TempleCell.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class TempleCell: BaseCell {
    
    let templeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let dividerView = UIView.getDivider()
    
    
    override func setUpViews() {
        super.setUpViews()
        
        contentView.addSubview(templeName)
        contentView.addSubview(dividerView)
        
        addConstrainsWithFormat(format: "H:|-20-[v0]|", views: templeName)
        addConstrainsWithFormat(format: "V:|[v0]|", views: templeName)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: dividerView)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: dividerView)
        
    }
}
