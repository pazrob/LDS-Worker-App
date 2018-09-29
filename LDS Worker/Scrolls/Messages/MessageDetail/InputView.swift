//
//  InputView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/13/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    var inputFieldHeightAnchor : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        setUpViews()
    }
    
    //InputContainer
    lazy var viewContainer : UIView = {
        let theView = UIView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.backgroundColor = .blue
        return theView
    }()
    
    lazy var viewBackground : UIView = {
        let theView = UIView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.backgroundColor = .white
        return theView
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        //textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isEditable = true
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.appEmptyColor
        textView.autoresizingMask = .flexibleHeight
        return textView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.appMainColor, for: .normal)
        button.setTitle("Send", for: .normal)
        return button
    }()
    
    func setUpViews() {
        
        addSubview(viewContainer)
        
        viewContainer.addSubview(viewBackground)
        viewContainer.addSubview(textView)
        viewContainer.addSubview(sendButton)
        
        viewContainer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        viewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        viewBackground.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        viewBackground.topAnchor.constraint(equalTo: textView.topAnchor, constant: -5).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5).isActive = true

        textView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -8).isActive = true
        inputFieldHeightAnchor = textView.heightAnchor.constraint(equalToConstant: 40)
        inputFieldHeightAnchor?.isActive = true
        textView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -5).isActive = true

        viewContainer.addConstrainsWithFormat(format: "V:|[v0]|", views: sendButton)
        sendButton.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: 0).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
