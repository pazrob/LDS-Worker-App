//
//  LegalViewcontroller.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    var type: String?
    var url: URL?
    
    override func viewDidLoad() {
        
        setUpNavigationBar()
        setUpViews()
        
    }
    
    let webView: UIWebView = {
        let web = UIWebView()
        return web
    }()
    
    func setUpViews() {
        
        view.backgroundColor = UIColor.white
        
        
        if let urlToLoad = url {
            webView.loadRequest(URLRequest(url: urlToLoad))
        }
        
        view.addSubview(webView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: webView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: webView)
    }
    
    func setUpNavigationBar() {
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let titleType = type {
            title = titleType
        }
    }

    
}
