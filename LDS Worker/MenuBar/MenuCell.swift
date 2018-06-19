
import UIKit

class MenuCell: BaseCell{
    
    //Views
    let menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.appOpaqueColor
        return imageView
    }()
    let menuText: UILabel = { //Menu Text
        let mt = UILabel()
        mt.textColor = UIColor.appOpaqueColor
        mt.font = UIFont.boldSystemFont(ofSize: 11)
        return mt
    }()
    
    //Effects
    override var isHighlighted: Bool { //Hightlight cell
        didSet{
            menuText.tintColor = isHighlighted ? UIColor.white : UIColor.appOpaqueColor
        }
    }
    override var isSelected: Bool { //Selected cell
        didSet{
            menuText.textColor = isSelected ? UIColor.white : UIColor.appOpaqueColor
            menuIcon.tintColor = isSelected ? UIColor.white : UIColor.appOpaqueColor
        }
    }
    
    //SetUpViews
    override func setUpViews(){
        super.setUpViews()
        
        addSubview(menuIcon)
        addSubview(menuText)
        
        //Sizes
        addConstrainsWithFormat(format: "H:[v0]", views: menuIcon)
        addConstrainsWithFormat(format: "V:[v0(23)]", views: menuIcon)
        addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuIcon, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        
        addConstrainsWithFormat(format: "H:[v0]", views: menuText)
        addConstrainsWithFormat(format: "V:[v0]", views: menuText)
        
        
        //Positions
        addConstraint(NSLayoutConstraint(item: menuText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuText, attribute: .top, relatedBy: .equal, toItem: menuIcon, attribute: .bottom, multiplier: 1, constant: 0))
        
    }
}
