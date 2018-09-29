//
//  TEST.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/10/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class RequestCellButton: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    let viewWhite : UIView = {
        let theView = UIView()
        theView.backgroundColor = .white
        theView.layer.cornerRadius = 8
        theView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        theView.layer.borderWidth = 0.5
        return theView
    }()
    
    
    let viewLabel : UILabel = {
        let label = UILabel()
        label.text = "Create a Request"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.appMainColor
        label.textAlignment = .left
        return label
    }()
    let iconAdd : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = UIColor.appMainColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setUpViews() {
        
        addSubview(viewWhite)
        viewWhite.addSubview(iconAdd)
        viewWhite.addSubview(viewLabel)
        
        addConstrainsWithFormat(format: "H:|-10-[v0]-10-|", views: viewWhite)
        addConstrainsWithFormat(format: "V:|[v0]|", views: viewWhite)
        
        addConstrainsWithFormat(format: "H:|-20-[v0(30)]", views: iconAdd)
        addConstrainsWithFormat(format: "V:[v0(30)]", views: iconAdd)
        iconAdd.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        viewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        viewLabel.leftAnchor.constraint(equalTo: iconAdd.rightAnchor, constant: 10).isActive = true
        addConstrainsWithFormat(format: "H:[v0]-20-|", views: viewLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

