//
//  DonateViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import SwiftyStoreKit

class DonateViewController: UIViewController {
    
    let inAppPurchaseIds = [
        "com.robinson.LDSWorker.consumable1",
        "com.robinson.LDSWorker.consumable2",
        "com.robinson.LDSWorker.consumable3",
        "com.robinson.LDSWorker.consumable4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftyStoreKit.retrieveProductsInfo(["com.robinson.LDSWorker.consumable1"]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
            }
        }
        
        
        
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






