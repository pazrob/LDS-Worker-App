//
//  RequestDetailViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI

class MyRequestDetailController: UIViewController {
    
    var isExpired = false
    var postDetails: Post?{
        
        didSet{
            
            //Get if post expired
            if let postDeadline = postDetails?.from {
                let timestamp = Date().timeIntervalSince1970
                isExpired = timestamp > postDeadline
            }
            
            handleDidSet()
        }
    }
    
    lazy var myRequestDetailView : MyRequestDetailView = {
        let mainView = MyRequestDetailView()
        mainView.scrollView.delegate = self
        mainView.statusButton.addTarget(self, action: #selector(handleChangeStatusRequest), for: .touchUpInside)
        mainView.deleteButton.addTarget(self, action: #selector(handleDeleteRequest), for: .touchUpInside)
        return mainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpViews()
    }
    
    private func setUpViews(){
        
        view.addSubview(myRequestDetailView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: myRequestDetailView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: myRequestDetailView)
    }
    
}












