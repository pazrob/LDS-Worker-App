//
//  LegalViewcontroller.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    var url: URL?
    
    init(urlPath: URL) {
        super.init(nibName: nil, bundle: nil)
        self.url = urlPath
    }
    
    
    override func viewDidLoad() {
        setUpViews()
    }
    
    
    func setUpViews() {
        
        //Set nav bar and view
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.white
        
        //Webview
        let webView = UIWebView()
        
        //Load the url
        guard let urlToLoad = url else { return }
        webView.loadRequest(URLRequest(url: urlToLoad))
        
        //Add webview
        view.addSubview(webView)
        webView.fillSuperview()
    }
    
    //Default
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
