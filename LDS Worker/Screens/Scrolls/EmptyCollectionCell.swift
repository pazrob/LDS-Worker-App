//
//  ScrollBackground.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/26/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class EmptyCollectionCell: BaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = .darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    let textView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.textColor = .darkGray
        text.font = text.font?.withSize(18)
        text.isEditable = false
        return text
    }()
    
    var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.appMainColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override func setUpViews() {
        
        
        addSubview(imageView)
        addSubview(label)
        addSubview(textView)
        addSubview(button)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
