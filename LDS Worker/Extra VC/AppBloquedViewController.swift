//
//  AppBloquedViewController.swift
//  LDS Worker
//
//  Created by Robinson Paz Jesus on 9/29/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


 //This is the view that displays when the app is bloqued for all users
//Reasons to block the app: Firebase costs, Legal Problems
 
 

class AppBloquedViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        
        //Clear nav bar
        navigationController?.navigationBar.isHidden = true
        
        //Add background and icon
        view.addVerticalGradientLayer(topColor: UIColor.appMainColor, bottomColor: UIColor.bottomGradient)
        
        //Add icon
        let icon = UIImageView()
        icon.image = UIImage(named: "mainIcon")
        icon.layer.cornerRadius = 25
        icon.layer.masksToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        //Add label
        let apologizeLabel = UILabel()
        apologizeLabel.textAlignment = .center
        apologizeLabel.font = apologizeLabel.font.withSize(17)
        apologizeLabel.translatesAutoresizingMaskIntoConstraints = false
        apologizeLabel.numberOfLines = 0
        apologizeLabel.textColor = .white
        apologizeLabel.text = "We have some issues in our servers due to the high volume of users.\nWe apreciate your patience as we work on them urgently.\nWe will update you soon.\n\n\n-LDS Worker Manager"
        
        view.addSubview(icon)
        view.addSubview(apologizeLabel)
        
        icon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        
        apologizeLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 30).isActive = true
        apologizeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        apologizeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        apologizeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
}
