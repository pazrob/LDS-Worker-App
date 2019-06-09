//
//  RequestView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/12/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.


import UIKit

class MyRequestDetailView : UIView {
    
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
    var statusButton = UIButton.getAppButton(text: "Mark as Covered")
    let deleteButton = UIButton.getAppGhostButton(text: "Delete Request")
    
    func setUpSubviews() {
        //Scroll View
        addSubview(scrollView)
        scrollView.fillSuperview()
        
        //HideScroll View
        scrollView.addSubview(hideScrollBackgroundView)
        hideScrollBackgroundView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, heightCons: 400)
        
        //Container View
        scrollView.addSubview(containerView)
        containerView.fillSuperview()
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
        
        footerView.addSubview(statusButton)
        footerView.addSubview(deleteButton)
   
        //Header Container
        headerView.anchor(top: nil, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, tCons: 0, lCons: 0, bCons: 0, rCons: 0, widthCons: 0, heightCons: 180)
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        headerTopConstraint?.isActive = true
        
        //Body Container
        bodyView.anchor(top: headerView.bottomAnchor, left: leftAnchor, bottom: labelStatus.bottomAnchor, right: rightAnchor, tCons: 30, bCons: -20)
        
        //Posted Label Constraints
        posted.anchor(left: leftAnchor, bottom: headerView.bottomAnchor, right: rightAnchor, bCons: 20, heightCons: 10)
        posted.anchorCenterXToSuperview()
        
        //Name Label
        nameLabel.anchor(left: leftAnchor, bottom: posted.topAnchor, right: rightAnchor, bCons: 5, heightCons: 20)
        nameLabel.anchorCenterXToSuperview()
        
        //Profile Picture Constraints
        profileWidthConstraint = profilePicture.widthAnchor.constraint(equalToConstant: 100)
        profileWidthConstraint?.isActive = true
        profileHeightConstraint = profilePicture.heightAnchor.constraint(equalToConstant: 100)
        profileHeightConstraint?.isActive = true
        profilePicture.anchorCenterXToSuperview()
        profilePicture.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10).isActive = true
        
        //Separator Line Constraints
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: divider1)
        //Separator Line Constraints
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        addConstrainsWithFormat(format: "V:|[v0(0.5)]", views: divider2)
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
        addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider3)
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
        footerView.anchor(top: bodyView.bottomAnchor, left: leftAnchor, bottom: containerView.bottomAnchor, right: rightAnchor, tCons: 30, heightCons: 160)
        
        //Buttons
        statusButton.anchor(top: footerView.topAnchor, tCons: 15, widthCons: 300, heightCons: 44)
        statusButton.anchorCenterXToSuperview()
        
        deleteButton.anchor(top: statusButton.bottomAnchor, tCons: 10,  widthCons: 300, heightCons: 44)
        deleteButton.anchorCenterXToSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
