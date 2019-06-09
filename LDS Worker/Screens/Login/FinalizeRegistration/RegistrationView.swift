//
//  RegistrationView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.appEmptyColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setUpSubviews()
    }
    
    let templeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "templeIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let explainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Find your Temple"
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        return label
    }()
    
    var searchField : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = UIColor.appMainColor
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    var templeCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.keyboardDismissMode = .interactive
        collection.isUserInteractionEnabled = true
        collection.alwaysBounceVertical = true
        collection.isHidden = true
        return collection
    }()
    
    var iconTopConstraint: NSLayoutConstraint?
    
    func setUpSubviews() {
        addSubview(templeIcon)
        addSubview(explainerLabel)
        addSubview(searchField)
        addSubview(templeCollection)
        
        addConstrainsWithFormat(format: "V:|-20-[v0(80)]", views: templeIcon)
        addConstrainsWithFormat(format: "H:[v0(80)]", views: templeIcon)
        templeIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addConstrainsWithFormat(format: "V:[v0]", views: explainerLabel)
        addConstrainsWithFormat(format: "H:[v0]", views: explainerLabel)
        explainerLabel.topAnchor.constraint(equalTo: templeIcon.bottomAnchor, constant: 10).isActive = true
        explainerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
                
        addConstrainsWithFormat(format: "V:[v0]", views: searchField)
        addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: searchField)
        searchField.topAnchor.constraint(equalTo: explainerLabel.bottomAnchor, constant: 10).isActive = true        
        
        addConstrainsWithFormat(format: "H:|-30-[v0]-30-|", views: templeCollection)
        templeCollection.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 0).isActive = true
        templeCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
