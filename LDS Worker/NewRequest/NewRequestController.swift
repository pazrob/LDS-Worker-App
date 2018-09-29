//
//  RequestController+Extension.swift
//  LDS Worker
//
//  Created by Robinson Paz 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class NewRequestController: UIViewController {
    
    let MAX_CHARACTERS = "150"
    var postId : String?
    weak var myRequestController: MyRequestDetailController?
    var requestToEdit: RequestEdit?
    var isNoteEmpty = true
    var isFromEmpty = true
    var isToEmpty = true
    let scrollUpConstant: CGFloat = -155
    var sendButton: UIBarButtonItem?
    
    lazy var mainView: NewRequestView = {
        let main = NewRequestView()
        main.scrollView.delegate = self
        main.noteField.delegate = self
        return main
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setUpViews()
        setUpToolBars()
        joinFieldsAndPickers()
        setUpUserInfo()
        
        if requestToEdit != nil {
            //Edit Request
            setUpNavigationBarForEditType()
            fetchDataToEdit()
        } else {
            //New Request
            setUpNavigationBarForNewType()
        }
        
    }
    
    func setUpViews() {
        view.addSubview(mainView)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: mainView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.noteField.becomeFirstResponder()
    }
    
}

