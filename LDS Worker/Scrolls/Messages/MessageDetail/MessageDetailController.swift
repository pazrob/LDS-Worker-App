//
//  MessageDetailControllerCollectionViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/26/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase


class MessageDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let messageTextCellId = "messageTextCellId"
    var partnerUser : UserModel?
    var messages = [MessageModel]()
    var timer: Timer?
    
    var partnerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        fetchNavBarInfo()
        fetchConversation()
        setUpCollectionView()
        observeKeyboard()
    }
    
    let navView: NavView = {
        let nv = NavView()
        nv.translatesAutoresizingMaskIntoConstraints = false
        nv.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nv.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return nv
    }()
    
    lazy var inputContainerView: InputView = {
        let iv = InputView()
        iv.sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        iv.textView.delegate = self
        iv.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        return iv
    }()
    
    override var inputAccessoryView: UIView? {
        get { return inputContainerView }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}




