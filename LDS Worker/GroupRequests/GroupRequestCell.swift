//
//  GroupRequestsCollectionViewCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class GroupRequestCell: BaseCell {
    
    var groupPost: Post? {
        didSet{
            if let firstName = groupPost?.author.firstName, let lastName = groupPost?.author.lastName {
                nameTitle.text = "Bro. \(lastName), \(firstName)"
            }
            
            if let profileImageName = groupPost?.author.imageURL {
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            
            if let dateLabel = groupPost?.from, let timeLabel = groupPost?.to{
                specifics.text = " \(dateLabel) - \(timeLabel)"
            }
            
            if let statusBool = groupPost?.status {
                if(statusBool){
                    status.text = "covered:"
                    status.textColor = UIColor.appMainColor
                }
                else{
                    status.text = "uncovered:"
                    status.textColor = UIColor.appUncovered
                }                
            }
            
            if let URLString = groupPost?.author.imageURL{
                print("This is my url:",URLString)
                if let imageURL = URL(string: URLString) {
                    ImageService.getImage(withURL: imageURL) { (profilePic) in
                        self.userProfileImageView.image = profilePic
                    }
                }
            } else { print("There was not url found!")}
        }
    }
    
    
  
    
    @objc func handleDefaultCell(){
        backgroundColor = UIColor.white
    }
    
 

    
    //View Cell Containers
    let containerView :UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //Circle subview
    let userProfileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultPortrait")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    //Line Separator subview
    let separatorView:UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.appLightGray
        return view
    }()
    //Tittle label subview
    let nameTitle:UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder: Name"
        return label
    }()
    //Specifics label subview
    let specifics: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.text = "Placeholder: Specifics"
        return label
    }()
    //Status label subview
    let status: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uncovered"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    //Adds the subviews in the cell
    override func setUpViews(){
        backgroundColor = UIColor.white
        
        addSubview(containerView)
        addSubview(userProfileImageView)
        containerView.addSubview(nameTitle)
        containerView.addSubview(status)
        containerView.addSubview(specifics)
        addSubview(separatorView)
        
        addConstrainsWithFormat(format: "H:|-82-[v0]-14-|", views: containerView)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//
        addConstrainsWithFormat(format: "H:|-14-[v0(60)]", views: userProfileImageView)
        addConstrainsWithFormat(format: "V:[v0(60)]", views: userProfileImageView)
        addConstraint(NSLayoutConstraint(item: userProfileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]|", views: nameTitle)
        containerView.addConstrainsWithFormat(format: "V:|[v0(20)]", views: nameTitle)
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]", views: status)
        containerView.addConstraint(NSLayoutConstraint(item: specifics, attribute: .left, relatedBy: .equal, toItem: status, attribute: .right, multiplier: 1, constant: 0))
        containerView.addConstrainsWithFormat(format: "V:|-20-[v0(20)]", views: status)
        containerView.addConstrainsWithFormat(format: "V:|-20-[v0(20)]", views: specifics)
        
        addConstrainsWithFormat(format: "H:|-80-[v0]|", views: separatorView)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: separatorView)
        
    }
    
    
    
}


//Fix: This extension works on the isClicked changed of color
extension GroupRequestCell {
    override var isSelected: Bool {
        didSet{
            if isSelected {
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
                perform(#selector(handleDefaultCell), with: nil, afterDelay: 0.3)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            if isSelected {
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            } else {
                backgroundColor = UIColor.white
            }
        }
    }
}

