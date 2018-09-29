//
//  GroupRequestsCollectionViewCell.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class MyRequestCell: BaseCell {
    
    var myPost: Post? {
        didSet{
            if let noteText = myPost?.note {
                noteLabel.text = noteText
            }
            
            if let dateLabel = myPost?.from {
                specifics.text = " \(Date.getStringDate(with: dateLabel)) - \(Date.getStringTime(with: dateLabel))"
            }
            
            if let statusBool = myPost?.status {
                if(statusBool){
                    status.text = AppContent.statusPositive.rawValue
                    status.textColor = UIColor.appMainColor
                }
                else{
                    status.text = AppContent.statusNegative.rawValue
                    status.textColor = UIColor.appUncovered
                }
            }
        }
    }
    
    
    //Cell
    let containerView :UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    let arrowDetail:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    let separatorView:UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.appLightGray
        return view
    }()
    let noteLabel:UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder: Name"
        return label
    }()
    let specifics: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.text = "Placeholder: Specifics"
        label.textColor = .darkGray
        return label
    }()
    let status: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.textAlignment = .right
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    //Adds the subviews in the cell
    override func setUpViews(){
        backgroundColor = UIColor.white
        addSubview(containerView)
        containerView.addSubview(noteLabel)
        containerView.addSubview(status)
        containerView.addSubview(arrowDetail)
        containerView.addSubview(specifics)
        addSubview(separatorView)
        
        
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: containerView)
        addConstrainsWithFormat(format: "V:|-15-[v0(40)]", views: containerView)
        
        containerView.addConstrainsWithFormat(format: "H:|[v0]-100-|", views: noteLabel)
        containerView.addConstrainsWithFormat(format: "V:|[v0(20)]", views: noteLabel)
        
        containerView.addConstrainsWithFormat(format: "H:[v0]-18-|", views: status)
        containerView.addConstrainsWithFormat(format: "V:[v0(20)]", views: status)
        containerView.addConstraint(NSLayoutConstraint(item: status, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addConstrainsWithFormat(format: "H:[v0(10)]|", views: arrowDetail)
        containerView.addConstrainsWithFormat(format: "V:[v0(20)]", views: arrowDetail)
        containerView.addConstraint(NSLayoutConstraint(item: arrowDetail, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addConstraint(NSLayoutConstraint(item: specifics, attribute: .left, relatedBy: .equal, toItem: noteLabel, attribute: .left, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: specifics, attribute: .top, relatedBy: .equal, toItem: noteLabel, attribute: .bottom, multiplier: 1, constant: 2))
        
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: separatorView)
        
    }
    
}

