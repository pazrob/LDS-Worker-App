//
//  SettingsTableViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/14/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBAction func handleSettingsDone(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    let settingTitles:[String] = ["TEMPLE WORKER ACCOUNT", "PREFERENCES", "MISCELLANEOUS", ""]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setLooks()
      
    }
    

    func setLooks(){
        
        //Table View looks
        tableView.backgroundColor = UIColor.appEmptyColor
        
        //Navigation Controller Bar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
                
        //Separator Color
        tableView.separatorColor = UIColor.white
        
        //Title Attributes
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nv = UIView()
        let label = UILabel()
        label.text = settingTitles[section]
        label.addCharacterSpacing(spacing: 1.1)
        label.font = label.font.withSize(13)
        label.textColor = UIColor.appDarkGray
        label.frame = CGRect(x: 18, y: 30, width: 300, height: 10)
        nv.addSubview(label)
        return nv
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            self.navigationController?.show(profileController, sender: self)
            
        case [2,0]:
            print("Donate")
            performSegue(withIdentifier: "donate", sender: self)
        case [2,1]:
            print("RATE APP VIEW")
        case [2,2]:
            print("FEEDBACK VIEW")
            handleFeedback()
        case [3,0]:
            print("LOGOUT VIEW")
            try! Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
//            handleLogOut()
        default:
            print("NADA")
            
        }
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
            self.present(composeCV, animated: true, completion: nil)
        }
        else{
            print("Cannot send Mail")
        }
    }
    
    private func handleLogOut(){
        let actionSheet = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func performLogOut(){
        try! Auth.auth().signOut()
    }
    
    


}
