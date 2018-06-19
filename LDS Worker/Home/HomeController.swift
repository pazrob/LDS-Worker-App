//
//  ViewController.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 4/27/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewWillAppear(_ animated: Bool) {
        print("cocha dice!")
        collectionView?.reloadData()
    }
    
    let messagesScrollId = "messagesScrollId"
    let myRequestScrollId = "myRequestScrollId"
    let groupRequestScrollId = "groupRequestScrollId"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Services calls
        DataService.loadPosts()
        ImageService.loadUserPicture()
        
        setUpNavigationBarItems()
        setUpCollectionView()
        setUpMenuBar()
        setUpRequestButton()
    }
    
    let requestButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "megaphoneIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.appMainColor
        btn.addTarget(self, action: #selector(handleNewRequestButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleNewRequestButton(){
        let requestStoryboard = UIStoryboard(name: "Request", bundle: nil)
        let requestController = requestStoryboard.instantiateInitialViewController()
        self.present(requestController!, animated: true, completion: nil)
    }    
    
    private func setUpRequestButton(){
        view.addSubview(requestButton)
        
        view.addConstrainsWithFormat(format: "H:[v0(50)]-10-|", views: requestButton)
        view.addConstrainsWithFormat(format: "V:[v0(50)]-10-|", views: requestButton)
        
    }
    
    @objc func handleTempleDetails(){
        print("show a temple")
    }
    
    @objc func handleDoneTempleDetails(){
        self.dismiss(animated: true, completion: nil)
    }
     
    func setUpNavigationBarItems(){
        navigationController?.navigationBar.isTranslucent = false //solid color
        
        //Top Item
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let titleButton = UIButton(type: .system)
        titleButton.setTitleColor(UIColor.white, for: .normal)
        titleButton.setTitle("Timpanogos Temple ›", for: .normal)
        titleButton.addTarget(self, action: #selector(handleTempleDetails), for: .touchUpInside)
        titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = titleButton
        
        //Left Setting Button
        let settingButton = UIButton(type: .system)
        settingButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
        settingButton.setImage(#imageLiteral(resourceName: "set"), for: .normal)
        settingButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        settingButton.tintColor = UIColor.white
        settingButton.imageView?.contentMode = .scaleAspectFit
        settingButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingButton)
        
        //Back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: .none)
    }
    
    //Handle Settings button
    @objc func handleSettingsButton(){
        let settingController = SettingController()
        let settingNavigation = UINavigationController(rootViewController: settingController)
        self.present(settingNavigation, animated: true, completion: nil)
    }
    
    func setUpCollectionView(){
        //Get access to the layout
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0 //no gaps
        }
        collectionView?.backgroundColor = UIColor.appEmptyColor
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        //Allows snap on horizontal cells
        collectionView?.isPagingEnabled = true
        
        //Register the video Cells
        collectionView?.register(MessageScroll.self, forCellWithReuseIdentifier: messagesScrollId)
        collectionView?.register(MyRequestScroll.self, forCellWithReuseIdentifier: myRequestScrollId)
        collectionView?.register(GroupRequestScroll.self, forCellWithReuseIdentifier: groupRequestScrollId)
        
//      collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //spacing fix scrolling bar
    }

    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition(rawValue: 0), animated: true)
    }
    
    //  <<<<< Menu BAR
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstrainsWithFormat(format: "V:|[v0(40)]", views: menuBar)
    }
    //  >>>>> Menu BAR
    
    //  <<<<<< Pushing Functions
    func showGroupRequestDetailController(withRequest: Post, isExpired: Bool){
        let appDetailController = GroupRequestDetailController()
        appDetailController.postDetails = withRequest
        appDetailController.isExpired = isExpired
        self.navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func showMyRequestDetailController(withRequest: Post, isExpired: Bool){
        let appDetailController = MyRequestDetailController()
        appDetailController.postDetails = withRequest
        appDetailController.isExpired = isExpired
        self.navigationController?.pushViewController(appDetailController, animated: true)
    }

}

extension HomeController {

   
    
    //>> 3 BIG-HORIZONTAL CELLS
    
    //Bar Movement Animation
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    //Activate higlights the text/menu sliding cells
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.menuCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: UICollectionViewScrollPosition.RawValue(0)))
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let scroll1 = collectionView.dequeueReusableCell(withReuseIdentifier: messagesScrollId, for: indexPath) as! MessageScroll
            scroll1.homeController = self
            return scroll1
        }
        if indexPath.item == 1 {
            let scroll2 = collectionView.dequeueReusableCell(withReuseIdentifier: myRequestScrollId, for: indexPath) as! MyRequestScroll
            scroll2.homeController = self
            return scroll2
        }
        if indexPath.item == 2 {
            let scroll3 = collectionView.dequeueReusableCell(withReuseIdentifier: groupRequestScrollId, for: indexPath) as! GroupRequestScroll
            scroll3.homeController = self
            return scroll3
        }
        let error = collectionView.dequeueReusableCell(withReuseIdentifier: "error", for: indexPath)
        return error
        
    }
    
    //Size of each page/cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 40)
    }
}




