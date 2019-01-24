//
//  SettingController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/13/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    let settingTitles:[String] = [UITextSettings.templeWorkerAccount.rawValue,
                                  UITextSettings.preferences.rawValue,
                                  UITextSettings.miscellaneous.rawValue,
                                  UITextSettings.legal.rawValue,
                                  UITextSettings.empty.rawValue,
                                  UITextSettings.empty.rawValue]
    
    let settingContent:[[String]] = [
                                      [UITextSettings.profile.rawValue,
                                       UITextSettings.updatePhoneNumber.rawValue],
                                      [UITextSettings.receiveNotifications.rawValue],
                                      [UITextSettings.share.rawValue,
                                       UITextSettings.rateApp.rawValue, UITextSettings.feedback.rawValue],
                                      [UITextSettings.termsAndConditions.rawValue, UITextSettings.dataPolicy.rawValue],
                                      [UITextSettings.signOut.rawValue, UITextSettings.eraseAccount.rawValue],
                                      [UITextSettings.empty.rawValue]
                                    ]
    
    var homeController: HomeController?
    let defaultCellId = "defaultCellId"
    let signatureCellId = "signatureCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    
    lazy var settingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.appEmptyColor
        collection.delegate = self
        collection.dataSource = self
        collection.register(SettingCell.self, forCellWithReuseIdentifier: defaultCellId)
        collection.register(SignatureCell.self, forCellWithReuseIdentifier: signatureCellId)
        collection.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collection.isScrollEnabled = true
        collection.bounces = true
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        setUpNavigationBar()
        setUpCollectionView()
        
    }
    
}
