//
//  File.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/13/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class NavView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    var navPicture: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultPortrait"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let navNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    lazy var navStack: UIStackView = {
        let ns = UIStackView(arrangedSubviews: [navPicture, navNameLabel])
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.spacing = 8
        ns.alignment = .center
        ns.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return ns
    }()
    
    func setUpViews() {

        addSubview(navStack)
        navStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
