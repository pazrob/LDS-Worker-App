

import UIKit

class MenuBar: UIView {
    
    var homeController: HomeController?
    var horizontalBarLeftConstraint : NSLayoutConstraint?
    let tabs = [ "My Requests", "Temple Requests"]
    let icons = ["personalIcon","groupIcon"]
    let cellId = "cellId"    
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = cv.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundView = blurredEffectView
        
        cv.backgroundColor = UIColor.clear
        cv.addShadow(size: CGSize(width: 0, height: -3),radious: 3, opacity: 0.05)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    let horizontalBarView: UIView = {
        let hbv = UIView()
        hbv.backgroundColor = UIColor.appMainColor
        hbv.translatesAutoresizingMaskIntoConstraints = false
        return hbv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpMenuCollection()
        
        //Animation Bar
        setUpHorizontalBar()
    }
    
    func setUpMenuCollection() {
        
        let indexpath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: indexpath, animated: false, scrollPosition: UICollectionView.ScrollPosition.left)
        
        addSubview(menuCollectionView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: menuCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: menuCollectionView)
        
    }
    
    func setUpHorizontalBar(){
        
        addSubview(horizontalBarView)
        
        horizontalBarLeftConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let denominator = CGFloat(tabs.count)
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/denominator).isActive = true
        
        horizontalBarView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //Default code
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


















