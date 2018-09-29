
import UIKit

class MenuCell: BaseCell{
    
    let menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    let menuText: UILabel = {
        let mt = UILabel()
        mt.textColor = UIColor.lightGray
        mt.font = mt.font.withSize(10)
        return mt
    }()
    
    let notificationLabel : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.backgroundColor = .red
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Effects
    override var isHighlighted: Bool {
        didSet{
            menuText.tintColor = isHighlighted ? UIColor.appMainColor : UIColor.darkGray
        }
    }
    override var isSelected: Bool {
        didSet{
            menuText.textColor = isSelected ? UIColor.appMainColor : UIColor.lightGray
            menuIcon.tintColor = isSelected ? UIColor.appMainColor : UIColor.lightGray
        }
    }
    
    override func setUpViews(){
        super.setUpViews()
        notificationLabel.isHidden = true
        addSubview(notificationLabel)
        addSubview(menuIcon)
        addSubview(menuText)        
        
        //Sizes
        addConstrainsWithFormat(format: "H:[v0]", views: menuIcon)
        addConstrainsWithFormat(format: "V:[v0(20)]", views: menuIcon)
        addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        menuIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]", views: menuText)
        addConstrainsWithFormat(format: "V:[v0]", views: menuText)
        
        
        //Positions
        addConstraint(NSLayoutConstraint(item: menuText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuText, attribute: .top, relatedBy: .equal, toItem: menuIcon, attribute: .bottom, multiplier: 1, constant: 0))
        
        notificationLabel.centerYAnchor.constraint(equalTo: menuIcon.centerYAnchor, constant: 0).isActive = true
        notificationLabel.centerXAnchor.constraint(equalTo: menuIcon.centerXAnchor, constant: 30).isActive = true
        notificationLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        notificationLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
    }
}
