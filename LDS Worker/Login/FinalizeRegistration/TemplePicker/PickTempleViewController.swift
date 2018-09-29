//
//  PickPhotoViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/7/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class PickTempleViewController: UIViewController {
    
    var potentialUser: UserRegistrationModel?
    var mainViewTopConstraint: NSLayoutConstraint?
    let templeCellId = "tempeleCellId"
    var baseTemples = TempleList.list
    lazy var filteredTemple = baseTemples
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        setUpViews()
    }
    
    lazy var mainView: RegistrationView = {
        let main = RegistrationView()
        main.templeCollection.register(TempleCell.self, forCellWithReuseIdentifier: templeCellId)
        main.templeCollection.delegate = self
        main.templeCollection.dataSource = self
        main.searchField.delegate = self
        main.explainerLabel.font = main.explainerLabel.font.withSize(20)
        return main
    }()
    
    private func setUpViews(){
        
        view.addSubview(mainView)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: mainView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.searchField.becomeFirstResponder()
    }
    
    
}
