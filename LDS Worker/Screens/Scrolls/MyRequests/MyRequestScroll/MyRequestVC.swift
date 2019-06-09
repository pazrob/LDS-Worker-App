//
//  GroupRequestCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class MyRequestVC: UIViewController {
    
    let myRequestCellId = "myRequestCellId"
    let headerId = "headerId"
    let emptyCellId = "emptyCellId"
    var myPosts = [Post]()
    
    enum EmptyStateCase: String {
        case mainTitle = "You have no requests"
        case subTitle = "Feel free to create a Request \n so that all the temple workers see it"
        case buttonText = ""
    }
    
    lazy var myrequestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 50, right: 0)
        cv.backgroundColor = UIColor.appEmptyColor
        cv.dataSource = self
        cv.delegate = self
        cv.register(MyRequestCell.self, forCellWithReuseIdentifier: myRequestCellId)
        cv.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: emptyCellId)
        cv.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    lazy var createRequestButton: RequestCellButton = {
        let crb = RequestCellButton()
        crb.isUserInteractionEnabled = true
        crb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRequestButton)))
        return crb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequests()
        //Checker
        addDataListener()
        //Views
        setUpCollectionView()
        setUpCreateRequestButton()
    }

    func getRequests(){
        myPosts = DataService.userPersonalPosts
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
