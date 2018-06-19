

import UIKit

class MenuBar: UIView {
    
    var homeController: HomeController?
    var horizontalBarLeftConstraint : NSLayoutConstraint?
    let tabs = ["Messages", "My Requests", "Group Requests"]
    let icons = ["messageIcon", "personalIcon","groupIcon"]
    let cellId = "cellId"
    
    //MENU - Collection View
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.appMainColor
        
        //Adding datasource and delegate to the collection view
        cv.delegate = self
        cv.dataSource = self
        cv.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    //Adding the subviews
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Adding subview elements
        addSubview(menuCollectionView)
        
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: menuCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: menuCollectionView)
        
        
        //Selects the fist icon on menu
        let selectedItemIndexPath = NSIndexPath(item: 0, section: 0) as IndexPath
        menuCollectionView.selectItem(at: selectedItemIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
        
        //Animation Bar
//        setUpHorizontalBar()
    }
    
    
    
    func setUpHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.appMainColor
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarView.layer.cornerRadius = 2
        addSubview(horizontalBarView)
        
        //x, y, width, height
        horizontalBarLeftConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftConstraint?.isActive = true
//        horizontalBarView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: horizontalBarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -2))
        let denominator = CGFloat(tabs.count)
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/denominator).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    
    
    //Default code
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //Cell Properties
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count //# of cells
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell //last part is so we can access the imageview
        cell.menuText.text = tabs[indexPath.item]
        let iconName = icons[indexPath.item]
        cell.menuIcon.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        cell.menuIcon.contentMode = .scaleAspectFit
        return cell //template cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let denominator = CGFloat(tabs.count)
        return CGSize(width: frame.width / denominator, height: frame.height) //size of cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //no spaces
    }
    //Control Pages with menu
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}
















