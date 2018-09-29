//
//  GroupRequestsCollectionViewCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: BaseCell {
    
    var theMessage: MessageModel? {
        didSet{
            
            setUpNameAndProfilePicture()
            
            if let text = theMessage?.text{
                if FirebaseService.currentUserProfile?.uid == theMessage?.fromId {
                    messagePick.text = "Me: \(text)"
                } else {
                    messagePick.text = text
                }
            }
            if let seconds = theMessage?.timestamp?.doubleValue {
                self.timeLabel.text = Date.getTimeStamp(with: seconds)
            }
        }
    }
    
    func setUpNameAndProfilePicture() {
        
        //Get partnerId
        if let chatPartnerId = theMessage?.getChatReceipientUID() {
            
            //Get your temple
            guard let temple = FirebaseService.currentUserProfile?.temple else { return }
            
            //
            Database.database().reference()
                .child(BaseNodes.users.rawValue)
                .child(temple)
                .child(chatPartnerId)
                .observeSingleEvent(of: DataEventType.value, with: { snapshot in
                    
                    if let dictionary = snapshot.value as? [String : Any],
                        let lastName = dictionary["lastName"] as? String,
                        let firstName = dictionary["firstName"] as? String,
                        let gender = dictionary["gender"] as? String {
                        
                        //Load name
                        self.senderName.text = "\(lastName), \(firstName)"
                        
                        //Fetch photo if available, load default for else
                        if let urlString = dictionary["photoURL"] as? String, let photoURL = URL(string: urlString) {
                            
                            //Fetch photo
                            ImageService.getImage(withURL: photoURL, completion: { downloadedPhoto in
                                
                                //Load default if nil, load photo for else
                                if downloadedPhoto == nil {
                                    DispatchQueue.main.async {
                                        self.senderPicture.image = UIImage.getGenderPhotoDefault(gender: gender)
                                    }                                    
                                } else {
                                    DispatchQueue.main.async {
                                        self.senderPicture.image = downloadedPhoto
                                    }
                                }
                            })
                            
                        } else {
                            //No photoURL node, or corrupted
                            self.senderPicture.image = UIImage.getGenderPhotoDefault(gender: gender)
                        }
                    }
                })
        }
    }
        
    //Cell
    let containerView :UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
    let senderPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.appMainColor
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let separatorView:UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.appLightGray
        return view
    }()
    let senderName:UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let messagePick: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.text = "Placeholder: Specifics"
        label.textColor = .darkGray
        return label
    }()
    let timeLabel: UILabel = {
        let label  = UILabel.getH4(text: "time")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textAlignment = .right
        return label
    }()
    
    override func setUpViews(){
        super.setUpViews()
        
        backgroundColor = UIColor.white
        addSubview(senderPicture)
        addSubview(containerView)
        containerView.addSubview(senderName)
        containerView.addSubview(timeLabel)
        containerView.addSubview(messagePick)
        addSubview(separatorView)
        
        addConstrainsWithFormat(format: "H:|-14-[v0(60)]", views: senderPicture)
        addConstrainsWithFormat(format: "V:[v0(60)]", views: senderPicture)
        addConstraint(NSLayoutConstraint(item: senderPicture, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: containerView)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: senderPicture, attribute: .right, multiplier: 1, constant: 14))
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]", views: senderName)
        containerView.addConstrainsWithFormat(format: "V:|[v0(20)]", views: senderName)
        
        containerView.addConstrainsWithFormat(format: "H:[v0]|", views: timeLabel)
        containerView.addConstrainsWithFormat(format: "V:|[v0]", views: timeLabel)
        
        containerView.addConstrainsWithFormat(format: "H:[v0]-60-|", views: messagePick)
        containerView.addConstraint(NSLayoutConstraint(item: messagePick, attribute: .left, relatedBy: .equal, toItem: senderName, attribute: .left, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: messagePick, attribute: .top, relatedBy: .equal, toItem: senderName, attribute: .bottom, multiplier: 1, constant: 2))
        
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: separatorView)
        
    }
    
}

