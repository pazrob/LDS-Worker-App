//
//  DonateViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nav Bar
        self.title = UITextSettings.donate.rawValue
        navigationItem.largeTitleDisplayMode = .never
        
        //Views
        setUpViews()
    }
    
    lazy var donateView: DonateView = {
        let mainView = DonateView()
        mainView.moneyPicker.dataSource = self
        mainView.moneyPicker.delegate = self
        mainView.donateButton.addTarget(self, action: #selector(handleDonation), for: .touchUpInside)
        return mainView
    }()
    
    private func setUpViews(){
        view.addSubview(donateView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: donateView)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: donateView)
    }

    
    @objc private func handleDonation(){
        print("Donating")
        let actionAlert = UIAlertController(title: "Thank you Katia!", message: "This really means a lot", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "You are welcome!", style: .default, handler: nil))
        self.navigationController?.present(actionAlert, animated: true, completion: nil)
    }
}






