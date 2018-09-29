//
//  NewRequestView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class NewRequestView: UIView {
    
    var headerTopConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.appEmptyColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setUpViews()
        setUpConstraints()
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.appEmptyColor
        scroll.delaysContentTouches = false
        scroll.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        return scroll
    }()
    
    let containerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.appEmptyColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let headerView = UIView.getContainer()
    let bodyView = UIView.getContainer()
    let profilePicture = UIImageView.getProfileFrame(with: ImageService.defaultPhotoString)
    let nameLabel = UILabel.getH2(text: "default Name")
    let templeLabel = UILabel.getH4(text: "default Temple")
    let phoneLabel = UILabel.getH4(text: "")
    
    let divider1 = UIView.getDivider()
    let divider2 = UIView.getDivider()
    let divider3 = UIView.getDivider()
    let divider4 = UIView.getDivider()
    let divider5 = UIView.getDivider()
    
    let footLabel = UILabel.getLabelFooterDefaults(text: "Your group will see this information")
    let noteLabel = UILabel.getLabelDescriptionDefaults(text: "WRITE A NOTE:")
    let counterLabel = UILabel.getLabelDescriptionDefaults(text: "0/150")
    let noteField = UITextView.getH2(isEditable: true)
    
    let fromLabel = UILabel.getLabelDescriptionDefaults(text: "FROM:")
    let toLabel = UILabel.getLabelDescriptionDefaults(text: "TO:")
    
    let dateField = UITextField.getPicker()
    let timeField = UITextField.getPicker()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker.getDatePicker()
        date.datePickerMode = UIDatePickerMode.dateAndTime
        date.minimumDate = Date(timeIntervalSinceNow: 0)
        var components = DateComponents()
        components.month = 1
        date.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        return date
    }()
    let timePicker: UIDatePicker = {
        let time = UIDatePicker.getDatePicker()
        time.datePickerMode = UIDatePickerMode.time
        time.minuteInterval = 10
        return time
    }()
    
    let footLabel2 = UILabel.getLabelFooterDefaults(text: "Requests whitin 30 days only")
    
    func setUpViews() {
        
        //Scroll View
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //Container View
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubview(headerView)
        containerView.addSubview(bodyView)
        
        headerView.addSubview(divider1)
        containerView.addSubview(footLabel)
        
        headerView.addSubview(profilePicture)
        headerView.addSubview(nameLabel)
        headerView.addSubview(templeLabel)
        headerView.addSubview(phoneLabel)
        
        bodyView.addSubview(divider2)
        bodyView.addSubview(noteLabel)
        bodyView.addSubview(counterLabel)
        bodyView.addSubview(noteField)
        bodyView.addSubview(divider3)
        bodyView.addSubview(fromLabel)
        bodyView.addSubview(dateField)
        bodyView.addSubview(divider4)
        bodyView.addSubview(toLabel)
        bodyView.addSubview(timeField)
        bodyView.addSubview(divider5)
        
        containerView.addSubview(footLabel2)
    }
    
    func setUpConstraints() {
        
        //Header Container
        headerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        headerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        headerTopConstraint?.isActive = true
        addConstrainsWithFormat(format: "V:[v0(140)]", views: headerView)
        
        //Body Container
        bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30).isActive = true
        bodyView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bodyView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 20).isActive = true
        
        addConstrainsWithFormat(format: "H:|-14-[v0(100)]", views: profilePicture)
        addConstrainsWithFormat(format: "V:|-20-[v0(100)]", views: profilePicture)
        
        addConstrainsWithFormat(format: "H:|-130-[v0]|", views: nameLabel)
        addConstrainsWithFormat(format: "V:|-40-[v0]", views: nameLabel)
        
        templeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        templeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        
        phoneLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: templeLabel.bottomAnchor, constant: 2).isActive = true
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider1)
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: footLabel)
        addConstraint(NSLayoutConstraint(item: footLabel, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 3))
        
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        addConstrainsWithFormat(format: "V:|[v0(0.3)]", views: divider2)
        
        addConstrainsWithFormat(format: "H:|-14-[v0]", views: noteLabel)
        addConstrainsWithFormat(format: "V:|-20-[v0]", views: noteLabel)
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: counterLabel)
        addConstrainsWithFormat(format: "V:|-20-[v0]", views: counterLabel)
        
        addConstraint(NSLayoutConstraint(item: noteField, attribute: .top, relatedBy: .equal, toItem: noteLabel, attribute: .bottom, multiplier: 1, constant: 5))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: noteField)
        noteField.heightAnchor.constraint(equalToConstant: 50)
        
        addConstraint(NSLayoutConstraint(item: divider3, attribute: .top, relatedBy: .equal, toItem: noteField, attribute: .bottom, multiplier: 1, constant: 0))
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider3)
        addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider3)
        
        addConstraint(NSLayoutConstraint(item: fromLabel, attribute: .top, relatedBy: .equal, toItem: noteField, attribute: .bottom, multiplier: 1, constant: 15))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: fromLabel)
        
        addConstraint(NSLayoutConstraint(item: dateField, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .bottom, multiplier: 1, constant: 5))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: dateField)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: dateField)
        
        addConstraint(NSLayoutConstraint(item: divider4, attribute: .top, relatedBy: .equal, toItem: fromLabel, attribute: .bottom, multiplier: 1, constant: 15))
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider4)
        addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider4)
        
        addConstraint(NSLayoutConstraint(item: toLabel, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 15))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: toLabel)
        
        addConstraint(NSLayoutConstraint(item: timeField, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 5))
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: timeField)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: timeField)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: divider5)
        addConstrainsWithFormat(format: "V:[v0(0.2)]|", views: divider5)
        
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: footLabel2)
        addConstraint(NSLayoutConstraint(item: footLabel2, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 3))
        
        footLabel2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
