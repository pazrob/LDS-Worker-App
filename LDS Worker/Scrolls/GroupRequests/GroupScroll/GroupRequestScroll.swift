//
//  GroupRequestCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//  

import UIKit

class GroupRequestScroll: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController : HomeController?
    var groupPosts = [[Post]]()
    var groupTitles = [TimeInterval]()
    
    let groupRequestCellId = "groupRequestCellId"
    let headerId = "headerId"
    let emptyCellId = "emptyCellId"
    
    enum EmptyStateCase: String {
        case mainTitle = "No requests from your temple"
        case subTitle = "Invite your friends \n to the LDS Work app"
        case buttonText = "Invite Friends"
    }
    
    lazy var groupRequestCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        cv.backgroundColor = UIColor.appScrollBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(GroupRequestCell.self, forCellWithReuseIdentifier: groupRequestCellId)
        cv.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: emptyCellId)
        cv.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        cv.bounces = true
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        //Fetch
        DataService.fetchTemplePosts()
        
        //Services
        getPosts()
        
        //Checker
        addDataListener()
        
        //Views
        setUpCollectionView()
    }
    
    func getPosts() {
        
        //Erase arrays in class
        groupPosts.removeAll()
        groupTitles.removeAll()
        
        for post in DataService.userGroupPosts {
                        
            //Get section header date
            let headerTimestamp = Date.getStartOfDay(from: post.from)
            
            //If section header exists, add the post into existing sub array
            if groupTitles.contains(headerTimestamp) {
                
                //Find out in what index
                if let index: Int = groupTitles.index(of: headerTimestamp) {
                    
                    //Find posts using the index and append
                    var posts = groupPosts[index]
                    posts.append(post)
                    groupPosts[index] = posts
                }
                
            } else {
                //Create a new header date
                groupTitles.append(headerTimestamp)
                
                //Add to an array
                var newPosts = [Post]()
                newPosts.append(post)
                groupPosts.append(newPosts)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}
