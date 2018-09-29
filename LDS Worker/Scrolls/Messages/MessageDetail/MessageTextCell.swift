//
//  MessageTextCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/29/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class MessageTextCell : BaseCell {
    
    var isMyBubble = Bool()
    var message : MessageModel? {
        didSet {
            if FirebaseService.currentUserProfile?.uid == message?.fromId {
                //Outgoing blue
                self.bubbleView.backgroundColor = UIColor.rgb(red: 0, green: 137, blue: 249)
                self.messageText.textColor = UIColor.white
                bubbleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
                
                self.bubbleRightAnchor?.isActive = true
                self.bubbleLeftAnchor?.isActive = false
            } else {
                //Incoming gray
                self.bubbleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                self.messageText.textColor = UIColor.black
                
                self.bubbleRightAnchor?.isActive = false
                self.bubbleLeftAnchor?.isActive = true
                bubbleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            }
            
            if let text = message?.text {
                self.messageText.text = text
//                let size = CGSize(width: self.frame.width, height: .infinity)
//                let estimadedSize = self.messageText.sizeThatFits(size)
//                messageHeightAnchor?.constant = estimadedSize.height
                
                let size = CGSize(width: 250, height: 1000)
                let estimadedSize = self.messageText.sizeThatFits(size)
                bubbleWidthAnchor?.constant = estimadedSize.width + 18
                
            }
        }
    }
    
    let bubbleView : UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.layer.cornerRadius = 12
        return bv
    }()
        
    let messageText : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.textColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    var bubbleLeftAnchor : NSLayoutConstraint?
    var bubbleRightAnchor : NSLayoutConstraint?
    var bubbleWidthAnchor : NSLayoutConstraint?
    
    var messageHeightAnchor : NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageText)
        
        contentView.addConstrainsWithFormat(format: "H:[v0]", views: bubbleView)
        contentView.addConstrainsWithFormat(format: "V:|[v0]|", views: bubbleView)
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleWidthAnchor?.priority = UILayoutPriority.init(rawValue: 999)
        
        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        bubbleRightAnchor?.isActive = true
        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)

        contentView.addConstrainsWithFormat(format: "H:|-6-[v0]-6-|", views: messageText)
        contentView.addConstrainsWithFormat(format: "V:|[v0]|", views: messageText)
        
        
    }
    
}
