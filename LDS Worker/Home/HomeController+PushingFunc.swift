//
//  HomeController+PushingFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension HomeController {
    
    func presentLoginController() {
        let loginVC = LoginViewController()
        present(loginVC, animated: true, completion: nil)
        //MARK: Destroy stack in navigation and leave login in memory
    }
    
    func showGroupRequestDetailController(withRequest: Post, isExpired: Bool){
        let appDetailController = GroupRequestDetailController()
        appDetailController.postDetails = withRequest
        self.navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func showMyRequestDetailController(withRequest: Post){
        let appDetailController = MyRequestDetailController()
        appDetailController.postDetails = withRequest
        self.navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func pushMessageDetailController(with userId: String){
        let layout = UICollectionViewFlowLayout()
        let messageDetailController = MessageDetailController(collectionViewLayout: layout)
        messageDetailController.partnerId = userId
        self.navigationController?.pushViewController(messageDetailController, animated: true)
    }
    
    @objc func handleNewRequestButton(){
        let newRequestNC = UINavigationController(rootViewController: NewRequestController())
        self.present(newRequestNC, animated: true, completion: nil)
    }
    
}
