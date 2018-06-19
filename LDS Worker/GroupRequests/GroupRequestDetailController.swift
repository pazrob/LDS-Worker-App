//
//  RequestDetailViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/18/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


class GroupRequestDetailController: UIViewController {
    
    var isExpired: Bool?
    var headerTopConstraint : NSLayoutConstraint?
    var profileWidthConstraint : NSLayoutConstraint?
    var profileHeightConstraint : NSLayoutConstraint?
    
    var postDetails: Post? {
        didSet{
            
            if let last = postDetails?.author.lastName, let first = postDetails?.author.firstName{
                nameLabel.text = "Brother \(last), \(first)"
            }
            
            if let postedOn = postDetails?.timeStamp{
                posted.text = "Posted \(postedOn)"
            }
            
            if let description = postDetails?.note{
                requestDescription.text = description
            }
            
            if let dateToCover = postDetails?.from, let timeToCover = postDetails?.to{
                dateField.text = "\(dateToCover) - \(timeToCover)"
            }
            
            if let isCovered = postDetails?.status{
                if(isCovered){
                    statusField.text = "Covered"
                    statusField.textColor = UIColor.appMainColor
                }
                else{
                    statusField.text = "Uncovered"
                    statusField.textColor = UIColor.appUncovered
                }
            }
            
            if let URLString = postDetails?.author.imageURL{
                print("This is my url:",URLString)
                if let imageURL = URL(string: URLString) {
                    ImageService.getImage(withURL: imageURL) { (profilePic) in
                        self.profilePicture.image = profilePic
                    }
                }
            } else { print("There was not url found!")}
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        setUpNavigationStyle()
        setUpViews()
        
    }
    
    private func setUpNavigationStyle(){        
        navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Group's Request"
    }
    
    lazy var scrollContainer: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
//        scroll.backgroundColor = UIColor.
        return scroll
    }()
    
    let headerView = UIView.getContainer()
    let bodyView = UIView.getContainer()
    
    let container: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor.white
        return cv
    }()
    let profilePicture = UIImageView.getProfileFrame(with: "uploadPhotoIcon")
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
    
    
    let requestDescription = UITextView.getH2(isEditable: false)
    let dateField = UILabel.getH3(text: "")
    let phoneField = UILabel.getH3(text: "")
    let statusField = UILabel.getH3(text: "")
    
    
    let labelNote = UILabel.getLabelDescriptionDefaults(text: "NOTE:")
    let dateLabel = UILabel.getLabelDescriptionDefaults(text: "DATE:")
    let phoneLabel = UILabel.getLabelDescriptionDefaults(text: "PHONE:")
    let labelStatus = UILabel.getLabelDescriptionDefaults(text: "STATUS:")
    
    let contactButton: UIButton = {
        let cb = UIButton.getAppButton(text: "Message")
        cb.addTarget(self, action: #selector(handleMessaButton), for: UIControlEvents.touchUpInside)
        return cb
    }()
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        return view
    }()
    
    @objc func handleMessaButton(){
        print("Handle message...")
        
    }
    
    private func setUpViews(){
        
        view.addSubview(scrollContainer)
        scrollContainer.addSubview(containerView)
        
        
        containerView.addSubview(headerView)
        containerView.addSubview(bodyView)
        headerView.addSubview(profilePicture)
        headerView.addSubview(nameLabel)
        headerView.addSubview(posted)
        headerView.addSubview(divider1)
//
        bodyView.addSubview(divider2)
        bodyView.addSubview(labelNote)
        bodyView.addSubview(requestDescription)
        bodyView.addSubview(divider3)
        bodyView.addSubview(dateLabel)
        bodyView.addSubview(dateField)
        bodyView.addSubview(divider4)
        bodyView.addSubview(phoneLabel)
        bodyView.addSubview(phoneField)
        bodyView.addSubview(divider5)
        bodyView.addSubview(labelStatus)
        bodyView.addSubview(statusField)
        bodyView.addSubview(divider6)

        containerView.addSubview(contactButton)

        view.addConstrainsWithFormat(format: "H:|[v0]|", views: scrollContainer)
        view.addConstrainsWithFormat(format: "V:|[v0]|", views: scrollContainer)

        scrollContainer.addConstrainsWithFormat(format: "V:[v0(180)]", views: containerView)
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))

        //Header Container
        headerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        headerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        headerTopConstraint?.isActive = true
        view.addConstrainsWithFormat(format: "V:[v0]", views: headerView)
        view.addConstraint(NSLayoutConstraint(item: headerView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0))

        //Body Container
        view.addConstraint(NSLayoutConstraint(item: bodyView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 30))
        bodyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bodyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        bodyView.bottomAnchor.constraint(equalTo: labelStatus.bottomAnchor, constant: 20).isActive = true
        view.addConstrainsWithFormat(format: "V:[v0]", views: bodyView)



        

        //Posted Label Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: posted)
        view.addConstrainsWithFormat(format: "V:[v0(10)]", views: posted)
        view.addConstraint(NSLayoutConstraint(item: posted, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: posted, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Name Label
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: nameLabel)
        view.addConstrainsWithFormat(format: "V:[v0(20)]", views: nameLabel)
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: posted, attribute: .top, multiplier: 1, constant: -5))
        view.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        
        //        Profile Picture Constraints
        profileWidthConstraint = profilePicture.widthAnchor.constraint(equalToConstant: 100)
        profileWidthConstraint?.isActive = true
        profileHeightConstraint = profilePicture.heightAnchor.constraint(equalToConstant: 100)
        profileHeightConstraint?.isActive = true
        view.addConstraint(NSLayoutConstraint(item: profilePicture, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: profilePicture, attribute: .bottom, relatedBy: .equal, toItem: nameLabel, attribute: .top, multiplier: 1, constant: -10))
        
        
        //Separator Line Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider1)
        //Separator Line Constraints
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        view.addConstrainsWithFormat(format: "V:|[v0(0.3)]", views: divider2)
        //Label Note Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: labelNote)
        view.addConstrainsWithFormat(format: "V:|-20-[v0]", views: labelNote)
        //Description Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: requestDescription)
        view.addConstrainsWithFormat(format: "V:[v0(50)]", views: requestDescription)
        view.addConstraint(NSLayoutConstraint(item: requestDescription, attribute: .top, relatedBy: .equal, toItem: labelNote, attribute: .bottom, multiplier: 1, constant: 5))
        //Separator Line Constraints
        view.addConstraint(NSLayoutConstraint(item: divider3, attribute: .top, relatedBy: .equal, toItem: requestDescription, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider3)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider3)

        //Label from Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: dateLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: dateLabel)
        view.addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .bottom, multiplier: 1, constant: 15))
        //Date Field
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: dateField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: dateField)
        view.addConstraint(NSLayoutConstraint(item: dateField, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .top, multiplier: 1, constant: 5))
        //Divider 4
        view.addConstraint(NSLayoutConstraint(item: divider4, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider4)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider4)

        //Label Phone Constraints
        view.addConstraint(NSLayoutConstraint(item: phoneLabel, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: phoneLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: phoneLabel)
        //Phone Field
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: phoneField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: phoneField)
        view.addConstraint(NSLayoutConstraint(item: phoneField, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 5))
        //        Divider 5
        view.addConstraint(NSLayoutConstraint(item: divider5, attribute: .top, relatedBy: .equal, toItem: phoneField, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider5)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]", views: divider5)
        //Label Status Constraints
        view.addConstrainsWithFormat(format: "H:|-14-[v0]", views: labelStatus)
        view.addConstrainsWithFormat(format: "V:[v0]", views: labelStatus)
        view.addConstraint(NSLayoutConstraint(item: labelStatus, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .bottom, multiplier: 1, constant: 15))
        //Status Constraints
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: statusField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: statusField)
        view.addConstraint(NSLayoutConstraint(item: statusField, attribute: .top, relatedBy: .equal, toItem: divider5, attribute: .top, multiplier: 1, constant: 5))
        // Divider 6
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider6)
        view.addConstrainsWithFormat(format: "V:[v0(0.5)]|", views: divider6)

        //Contact Button Constraints
        view.addConstrainsWithFormat(format: "H:|-40-[v0]-40-|", views: contactButton)
        view.addConstrainsWithFormat(format: "V:[v0(42)]", views: contactButton)
        view.addConstraint(NSLayoutConstraint(item: contactButton, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: contactButton, attribute: .centerX, relatedBy: .equal, toItem: bodyView, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    
}

extension GroupRequestDetailController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            let dimensionValue = 100 + (-scrollView.contentOffset.y)
            profilePicture.layer.cornerRadius = dimensionValue / 2
            headerTopConstraint?.constant = scrollView.contentOffset.y
            profileWidthConstraint?.constant = dimensionValue
            profileHeightConstraint?.constant = dimensionValue
        }
        
    }
    
}
















