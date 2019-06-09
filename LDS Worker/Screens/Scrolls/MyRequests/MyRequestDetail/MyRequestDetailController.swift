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
    var postDetails: Post?
    
    convenience init(post: Post) {
        self.init()
        self.postDetails = post
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
        loadContent()
    }
    
    private func setUpViews(){
        view.backgroundColor = .red
        view.addSubview(myRequestDetailView)
        myRequestDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
}












