//
//  CreateRequest.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/21/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class CreateRequest: UIViewController {
    
    let container: UIView = {
        let newView = UIView()
        newView.backgroundColor = .white
        newView.layer.cornerRadius = 8
        return newView
    }()
    let newLabel: UILabel = {
        let label = UILabel()
        label.text = "New papas"
        label.textColor = UIColor.appMainColor
        label.textAlignment = .center
        return label
    }()
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return btn
    }()
    
    @objc private func handleCloseButton(){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        
        view.addSubview(container)
        container.addSubview(newLabel)
        container.addSubview(closeButton)
        
        view.addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: container)
        view.addConstrainsWithFormat(format: "V:|-50-[v0]-50-|", views: container)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: newLabel)
        view.addConstrainsWithFormat(format: "V:|-50-[v0]", views: newLabel)
        
        view.addConstrainsWithFormat(format: "H:|-20-[v0]-20-|", views: closeButton)
        view.addConstrainsWithFormat(format: "V:[v0]-20-|", views: closeButton)
    }
}
