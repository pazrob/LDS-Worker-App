//
//  RequestView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//
// kasjhd kasjdh aksjhdkasjdh kashd kash dkajshd kajshd kajsh dkjhashd asd
// askdja sldkjas lkdj alskdj laskjd laskjd lkasj dlkas jldkja sldkjaslkdjas
//aslda lksdj laksd lkas dlkasjd lkasjd lkasjdlkajs dklajskdjhasjhdasjhdasd
import UIKit

class RequestDetailView : UIView {
    
    var headerTopConstraint : NSLayoutConstraint?
    var profileWidthConstraint : NSLayoutConstraint?
    var profileHeightConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.appEmptyColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setUpSubviews()
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.appEmptyColor
        scroll.delaysContentTouches = false
        return scroll
    }()
    
    let containerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.appEmptyColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let hideScrollBackgroundView : UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let headerView = UIView.getContainer()
    let bodyView = UIView.getContainer()
    let footerView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .clear
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    let profilePicture = UIImageView.getProfileFrame(with: nil)
    
    let nameLabel: UILabel = {
        let label = UILabel.getH2(text: "Name")
        label.textAlignment = .center
        return label
    }()
    let posted = UILabel.getLabelSubtitlePostedDefaults()
    let divider1 = UIView.getDivider()
    let divider2 = UIView.getDivider()
    let divider3 = UIView.getDivider()
    let divider4 = UIView.getDivider()
    let divider5 = UIView.getDivider()
    let divider6 = UIView.getDivider()
    
    
    let noteField = UITextView.getH2(isEditable: false)
    let fromField = UILabel.getH3(text: "")
    let toField = UILabel.getH3(text: "")
    let statusField = UILabel.getH3(text: "")
    
    
    let labelNote = UILabel.getLabelDescriptionDefaults(text: "NOTE:")
    let fromLabel = UILabel.getLabelDescriptionDefaults(text: "FROM:")
    let toLabel = UILabel.getLabelDescriptionDefaults(text: "TO:")
    let labelStatus = UILabel.getLabelDescriptionDefaults(text: "STATUS:")
    
    lazy var callButton : UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: PictureKeys.callIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = .white
        button.backgroundColor = UIColor.appMainColor
        button.layer.cornerRadius = 30
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var messageButton : UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: PictureKeys.messageIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = .white
        button.backgroundColor = UIColor.appMainColor
        button.layer.cornerRadius = 30
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    func setUpSubviews() {
        
        let optionsStack = UIStackView(arrangedSubviews: [callButton, messageButton])
        optionsStack.alignment = .trailing
        optionsStack.axis = .horizontal
        optionsStack.spacing = 10
        
        //Scroll View
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //HideScroll View
        scrollView.addSubview(hideScrollBackgroundView)
        hideScrollBackgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        hideScrollBackgroundView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        hideScrollBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        //Container View
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubview(headerView)
        containerView.addSubview(bodyView)
        containerView.addSubview(footerView)
        
        
        headerView.addSubview(profilePicture)
        headerView.addSubview(nameLabel)
        headerView.addSubview(posted)
        headerView.addSubview(divider1)
        
        bodyView.addSubview(divider2)
        bodyView.addSubview(labelNote)
        bodyView.addSubview(noteField)
        bodyView.addSubview(divider3)
        
        bodyView.addSubview(fromLabel)
        bodyView.addSubview(fromField)
        bodyView.addSubview(divider4)
        bodyView.addSubview(toLabel)
        bodyView.addSubview(toField)
        
        
        bodyView.addSubview(divider5)
        bodyView.addSubview(labelStatus)
        bodyView.addSubview(statusField)
        bodyView.addSubview(divider6)
        
        
        footerView.addSubview(optionsStack)
        
        //Header Container
        headerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        headerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        headerTopConstraint?.isActive = true
        addConstrainsWithFormat(format: "V:[v0(180)]", views: headerView)
        
        //Body Container
        bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30).isActive = true
        bodyView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bodyView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: labelStatus.bottomAnchor, constant: 20).isActive = true
        
        //Posted Label Constraints
        addConstrainsWithFormat(format: "H:|[v0]|", views: posted)
        addConstrainsWithFormat(format: "V:[v0(10)]", views: posted)
        addConstraint(NSLayoutConstraint(item: posted, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: posted, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Name Label
        addConstrainsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstrainsWithFormat(format: "V:[v0(20)]", views: nameLabel)
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: posted, attribute: .top, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Profile Picture Constraints
        profileWidthConstraint = profilePicture.widthAnchor.constraint(equalToConstant: 100)
        profileWidthConstraint?.isActive = true
        profileHeightConstraint = profilePicture.heightAnchor.constraint(equalToConstant: 100)
        profileHeightConstraint?.isActive = true
        addConstraint(NSLayoutConstraint(item: profilePicture, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: profilePicture, attribute: .bottom, relatedBy: .equal, toItem: nameLabel, attribute: .top, multiplier: 1, constant: -10))
        
        //Separator Line Constraints
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider1)
        //Separator Line Constraints
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        addConstrainsWithFormat(format: "V:|[v0(0.3)]", views: divider2)
        //Label Note Constraints
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: labelNote)
        addConstrainsWithFormat(format: "V:|-20-[v0]", views: labelNote)
        //NoteField Constraints
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: noteField)
        addConstrainsWithFormat(format: "V:[v0]", views: noteField)
        addConstraint(NSLayoutConstraint(item: noteField, attribute: .top, relatedBy: .equal, toItem: labelNote, attribute: .bottom, multiplier: 1, constant: 5))
        //Separator Line Constraints
        addConstraint(NSLayoutConstraint(item: divider3, attribute: .top, relatedBy: .equal, toItem: noteField, attribute: .bottom, multiplier: 1, constant: 0))
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider3)
        addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider3)
        
        //Label from Constraints
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: fromLabel)
        addConstraint(NSLayoutConstraint(item: fromLabel, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .bottom, multiplier: 1, constant: 15))
        //From Field
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromField)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: fromField)
        addConstraint(NSLayoutConstraint(item: fromField, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .top, multiplier: 1, constant: 5))
        //Divider 4
        addConstraint(NSLayoutConstraint(item: divider4, attribute: .top, relatedBy: .equal, toItem: fromLabel, attribute: .bottom, multiplier: 1, constant: 15))
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider4)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider4)
        //Label to Constraints
        addConstraint(NSLayoutConstraint(item: toLabel, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 15))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: toLabel)
        //To Field
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toField)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: toField)
        addConstraint(NSLayoutConstraint(item: toField, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 5))
        //        Divider 5
        addConstraint(NSLayoutConstraint(item: divider5, attribute: .top, relatedBy: .equal, toItem: toField, attribute: .bottom, multiplier: 1, constant: 0))
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider5)
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider5)
        //Label to Constraints
        addConstrainsWithFormat(format: "H:|-14-[v0]", views: labelStatus)
        addConstrainsWithFormat(format: "V:[v0]", views: labelStatus)
        addConstraint(NSLayoutConstraint(item: labelStatus, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .bottom, multiplier: 1, constant: 15))
        
        //Status Constraints
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: statusField)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: statusField)
        addConstraint(NSLayoutConstraint(item: statusField, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .top, multiplier: 1, constant: 5))
        // Divider 6
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider6)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: divider6)
        
        //Footer Container
        footerView.topAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: 30).isActive = true
        footerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        footerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        footerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
     
        //Buttons
        addConstrainsWithFormat(format: "H:[v0]", views: optionsStack)
        addConstrainsWithFormat(format: "V:|[v0]", views: optionsStack)
        optionsStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


