//
//  RequestDetailViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


class GroupRequestDetailController: UIViewController {
    
    var postDetails: Post? {
        didSet{
            handleDidSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpViews()
    }
    
    lazy var requestDetailView : RequestDetailView = {
        let mainView = RequestDetailView()
        mainView.scrollView.delegate = self
        mainView.messageButton.addTarget(self, action: #selector(self.handleMessageButton), for: .touchUpInside)
        mainView.callButton.addTarget(self, action: #selector(self.handleCallButton), for: .touchUpInside)
        return mainView
    }()
    
    private func setUpViews(){
        
        requestDetailView.isUserInteractionEnabled = true
        view.addSubview(requestDetailView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: requestDetailView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: requestDetailView)        
      
    }
    
    
}
