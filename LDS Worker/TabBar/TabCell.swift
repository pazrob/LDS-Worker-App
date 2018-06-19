
import UIKit

class TabCell: BaseCell{
    
    var iconHeightConstraint : NSLayoutConstraint?
    var iconWidthConstraint : NSLayoutConstraint?
    
    
    var tabModel: TabModel?{
        didSet{
            if let text = tabModel?.tabText{
                tabText.text = text
                tabText.font = tabText.font.withSize(9)
                if text == "Middle"{
                    tabText.isHidden = true
                    iconHeightConstraint?.isActive = false
                    iconWidthConstraint?.isActive = false
                    tabIcon.heightAnchor.constraint(equalToConstant: 39).isActive = true
                    tabIcon.widthAnchor.constraint(equalToConstant: 39).isActive = true
                }
            }
            if let icon = tabModel?.tabIcon{
                tabIcon.image = UIImage(named: "\(icon)Line")
                tabIcon.image = tabIcon.image?.withRenderingMode(.alwaysTemplate)
                tabIcon.tintColor = UIColor.gray
                tabIcon.contentMode = UIViewContentMode.scaleAspectFill
            }
        }
    }
    
    
    //Views
    let tabText: UILabel = { //Menu Text
        let mt = UILabel()
        mt.font = mt.font.withSize(9)
        return mt
    }()
    let tabIcon: UIImageView = {
        let ti = UIImageView()
        return ti
    }()
    let requestIcon: UIImageView = {
        let ti = UIImageView(image: #imageLiteral(resourceName: "megaphoneIcon") )
        return ti
    }()
    
    
    //Effects
//    override var isHighlighted: Bool { //Hightlight cell
//        didSet{
//            self.tabText.textColor = isHighlighted ? UIColor.appMainColor : UIColor.gray
//            self.tabIcon.tintColor = isHighlighted ? UIColor.appMainColor : UIColor.gray
//        }
//    }
//    override var isSelected: Bool { //Selected cell
//        didSet{
//            changeCellSelection(when: isSelected)
//        }
//    }
    
    private func changeCellSelection(when isSelected: Bool){
        if(isSelected){
            if let icon = tabModel?.tabIcon{
                tabIcon.image = UIImage(named: icon)
                tabIcon.image = tabIcon.image?.withRenderingMode(.alwaysTemplate)
                tabIcon.tintColor = UIColor.appMainColor
                tabIcon.contentMode = UIViewContentMode.scaleAspectFill
                self.tabText.textColor = UIColor.appMainColor
            }
        }
        else{
            if let icon = tabModel?.tabIcon{
                tabIcon.image = UIImage(named: "\(icon)Line")
                tabIcon.image = tabIcon.image?.withRenderingMode(.alwaysTemplate)
                tabIcon.tintColor = UIColor.gray
                tabIcon.contentMode = UIViewContentMode.scaleAspectFill
                self.tabText.textColor = UIColor.gray
            }
        }
        
    }
    
    
    
    //SetUpViews
    override func setUpViews(){
        super.setUpViews()
        
        addSubview(tabIcon)
        addSubview(tabText)
        
        //Sizes
        addConstrainsWithFormat(format: "H:[v0]", views: tabIcon)
        addConstrainsWithFormat(format: "V:|-4-[v0]", views: tabIcon)
        iconHeightConstraint = tabIcon.heightAnchor.constraint(equalToConstant: 30)
        iconHeightConstraint?.isActive = true
        iconWidthConstraint = tabIcon.widthAnchor.constraint(equalToConstant: 30)
        iconWidthConstraint?.isActive = true
        
        addConstrainsWithFormat(format: "H:[v0]", views: tabText)
        addConstrainsWithFormat(format: "V:[v0]-1-|", views: tabText)
        
        
        //Positions
        addConstraint(NSLayoutConstraint(item: tabText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: menuText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tabIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: tabIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    
}
