//
//  profileCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/31/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell{    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.textAlignment = .right
        field.isUserInteractionEnabled = false
        return field
    }()
    
    
    override func setUpViews(){
        backgroundColor = .white
        addSubview(descriptionLabel)
        addSubview(textField)
        
        addConstrainsWithFormat(format: "H:|-14-[v0]", views: descriptionLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: descriptionLabel)
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: textField)
        addConstrainsWithFormat(format: "V:[v0]", views: textField)
        addConstraint(NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}


