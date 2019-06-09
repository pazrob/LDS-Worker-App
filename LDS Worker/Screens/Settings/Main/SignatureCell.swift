//
//  SettingCell.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class SignatureCell: BaseCell {
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
//        imageView.alpha = 0.4
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        
        label.text = "\(UITextSettings.copyright) \(year) \n \(UITextSettings.version.rawValue)"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override func setUpViews() {
        
        contentView.addSubview(logoImage)
        contentView.addSubview(cellLabel)
        
        addConstrainsWithFormat(format: "V:[v0(100)]", views: logoImage)
        addConstrainsWithFormat(format: "H:[v0(100)]", views: logoImage)
        logoImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        
        addConstrainsWithFormat(format: "V:[v0]", views: cellLabel)
        addConstrainsWithFormat(format: "H:[v0]", views: cellLabel)
        cellLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellLabel.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 0).isActive = true
    }
}
