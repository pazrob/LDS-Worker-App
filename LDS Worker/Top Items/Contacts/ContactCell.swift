

import UIKit

class ContactCell : BaseCell {
    
    var contactsController: ContactsController?
    var uid: String?
    var cellPhoneNumber: String?
    
    let containerView : UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        return whiteView
    }()
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        return label
    }()
    
    let phoneNumber : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let userPhoto : UIImageView = {
        let defaultImage = UIImage(named: PictureKeys.brotherDefault.rawValue)
        let imageView = UIImageView(image: defaultImage)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let backDot: UIView = {
        let backV = UIView.getContainer()
        backV.layer.cornerRadius = 9
        return backV
    }()
    let genderDot: UIView = {
        let gView = UIView()
        gView.backgroundColor = .gray
        gView.translatesAutoresizingMaskIntoConstraints = false
        gView.layer.cornerRadius = 6
        return gView
    }()
    
    lazy var callButton : UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: PictureKeys.callIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.tintColor = .white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 19
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCallingButton), for: .touchUpInside)
        return button
    }()
    
    lazy var messageButton : UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: PictureKeys.messageIcon.rawValue)?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.tintColor = .white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 19
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTextingButton), for: .touchUpInside)
        return button
    }()
    
    override func setUpViews() {
        super.setUpViews()
        setUpCell()
    }

    @objc func handleTextingButton() {
        
        guard let number = cellPhoneNumber else { return }
        guard let name = fullNameLabel.text else { return }
        
        contactsController?.messagePhone(fullName: name, number: number)
        
    }
    
    @objc func handleCallingButton() {
        
        guard let number = cellPhoneNumber else { return }
        guard let name = fullNameLabel.text else { return }
        
        contactsController?.callCellPhone(name: name, number: number)
    }
    
    func setUpCell() {
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addShadow(size: CGSize(width: 0, height: 3), radious: 3, opacity: 0.05)
        
        let optionsStack = UIStackView(arrangedSubviews: [callButton, messageButton])
        optionsStack.alignment = .trailing
        optionsStack.axis = .horizontal
        optionsStack.spacing = 5
        
        contentView.addSubview(containerView)
        containerView.addSubview(userPhoto)
        containerView.addSubview(backDot)
        containerView.addSubview(genderDot)
        containerView.addSubview(fullNameLabel)
        containerView.addSubview(phoneNumber)
        containerView.addSubview(optionsStack)
        
        addConstrainsWithFormat(format: "H:|-10-[v0]-10-|", views: containerView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: containerView)
        
        
        addConstrainsWithFormat(format: "H:|-14-[v0(60)]", views: userPhoto)
        addConstrainsWithFormat(format: "V:[v0(60)]", views: userPhoto)
        userPhoto.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0(12)]", views: genderDot)
        addConstrainsWithFormat(format: "V:[v0(12)]", views: genderDot)
        genderDot.centerYAnchor.constraint(equalTo: userPhoto.centerYAnchor, constant: 22).isActive = true
        genderDot.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor, constant: 22).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0(18)]", views: backDot)
        addConstrainsWithFormat(format: "V:[v0(18)]", views: backDot)
        backDot.centerYAnchor.constraint(equalTo: genderDot.centerYAnchor).isActive = true
        backDot.centerXAnchor.constraint(equalTo: genderDot.centerXAnchor).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]-100-|", views: fullNameLabel)
        addConstrainsWithFormat(format: "V:[v0]", views: fullNameLabel)
        fullNameLabel.leftAnchor.constraint(equalTo: userPhoto.rightAnchor, constant: 10).isActive = true
        fullNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -5).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]", views: phoneNumber)
        addConstrainsWithFormat(format: "V:[v0]", views: phoneNumber)
        phoneNumber.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor).isActive = true
        phoneNumber.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 2).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]-15-|", views: optionsStack)
        addConstrainsWithFormat(format: "V:[v0]", views: optionsStack)
        optionsStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}
