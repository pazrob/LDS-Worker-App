//
//  SettingController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/13/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MessageUI

class SettingController: UIViewController {
    
    let settingTitles:[String] = ["TEMPLE WORKER ACCOUNT", "PREFERENCES", "MISCELLANEOUS", ""]
    let settingContent:[[String]] = [
                                      ["Profile"],
                                      ["Availability", "Receive Notifications"],
                                      ["Donate", "Rate App", "Feedback"],
                                      ["Sign Out"]
                                    ]
    let defaultCellId = "defaultCellId"
    let headerId = "headerId"
    let footerId = "footerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpNavigationBar()
        setUpCollectionView()
        
    }
    
    func setUpNavigationBar() {
        
        self.title = "Settings"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
        //Title Attributes
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    @objc func handleDone(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    lazy var settingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.appEmptyColor
        collection.delegate = self
        collection.dataSource = self
        collection.register(SettingCell.self, forCellWithReuseIdentifier: defaultCellId)
        collection.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collection.isScrollEnabled = true
        collection.bounces = true
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    func setUpCollectionView() {
        view.addSubview(settingCollection)
        
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: settingCollection)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: settingCollection)
    }
    
    
    
    private func handleLogOut(){
        let actionSheet = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    @objc func performLogOut(){
        try! Auth.auth().signOut()
    }
}

extension SettingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return headers[section]
        return settingContent[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = settingCollection.dequeueReusableCell(withReuseIdentifier: defaultCellId, for: indexPath) as! SettingCell
        cell.cellLabel.text = settingContent[indexPath.section][indexPath.item]
        if settingTitles[indexPath.section] != "PREFERENCES" {
            cell.cellSwitch.isHidden = true
        } else {
            cell.detailArrow.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50) //size of cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 1 {
            print("Nada a donde mandar")
            return
        }
        openSelection(atIndexPath: indexPath)
    }
    
    private func openSelection(atIndexPath: IndexPath){
        let path = atIndexPath
        
        switch path{
        case [0,0]:
            //profile
            print("Profile")
            let profileController = ProfileViewController()
            self.navigationController?.pushViewController(profileController, animated: true)
            
        case [2,0]:
            print("Donate")
            let donateController = DonateViewController()
            self.navigationController?.pushViewController(donateController, animated: true)
        case [2,1]:
            print("RATE APP VIEW")
        case [2,2]:
            print("FEEDBACK VIEW")
            handleFeedback()
        case [3,0]:
            print("LOGOUT VIEW")
            try! Auth.auth().signOut()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
//            handleLogOut()
        default:
            print("NADA")
            
        }
    }
    
    
}


extension SettingController {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
            header.headerLabel.text = settingTitles[indexPath.section]
            return header
//        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension SettingController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func handleFeedback(){
        let composeCV = MFMailComposeViewController()
        composeCV.mailComposeDelegate = self
        
        if(MFMailComposeViewController.canSendMail()){
            
            //Configure the fields of the interface
            composeCV.setMessageBody("Hi Robinson Paz,\n", isHTML: false)
            composeCV.setSubject("LDS Worker - Feedback")
            composeCV.setToRecipients(["robinson.paz.jesus@gmail.com"])
            
            //Present the ViewController
            present(composeCV, animated: true, completion: nil)
        }
        else{
            print("Cannot send Mail")
        }
    }
}


class SettingCell: BaseCell {
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    let detailArrow : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cellSwitch : UISwitch = {
        let switchItem = UISwitch()
        switchItem.onTintColor = UIColor.appMainColor
        return switchItem
    }()
    
    override func setUpViews() {
        backgroundColor = UIColor.white
        
        addSubview(cellLabel)
        addSubview(detailArrow)
        addSubview(cellSwitch)
        
        addConstrainsWithFormat(format: "V:[v0]", views: cellSwitch)
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: cellSwitch)
        cellSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        addConstrainsWithFormat(format: "V:|[v0]|", views: cellLabel)
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: cellLabel)
        
        addConstrainsWithFormat(format: "V:[v0(15)]", views: detailArrow)
        addConstrainsWithFormat(format: "H:[v0(15)]-14-|", views: detailArrow)
        detailArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}














