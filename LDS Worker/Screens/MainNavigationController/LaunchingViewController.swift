//
//  LaunchingViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        view.addVerticalGradientLayer(topColor: UIColor.appMainColor,
                                      bottomColor: UIColor.bottomGradient)
        
        let logo = UIImage(named: "loginIcon")?.withRenderingMode(.alwaysTemplate)
        let logoView = UIImageView(image: logo)
        logoView.tintColor = .white
        logoView.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(logoView)
        
        logoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }

}
