//
//  RequestDetailViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


class GroupRequestDC: UIViewController {
    
    var postDetails: Post?
    
    convenience init(post: Post) {
        self.init()
        self.postDetails = post
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
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
        requestDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func setUpNavigationBar(){
        //Title Attributes
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Temple Requests"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: nil)
    }
}

extension GroupRequestDC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let dimensionValue = 100 + (-scrollView.contentOffset.y)
            requestDetailView.profilePicture.layer.cornerRadius = dimensionValue / 2
            requestDetailView.profileWidthConstraint?.constant = dimensionValue
            requestDetailView.profileHeightConstraint?.constant = dimensionValue
        }
    }
    
}
