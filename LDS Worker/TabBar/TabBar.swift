

import UIKit

class TabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var homeController: HomeController?
    var barTabModels: [TabModel]?
    
    func loadData(){
        barTabModels = {
            let tab1 = TabModel()
            tab1.tabIcon = "templeIcon"
            tab1.tabText = "Home"
            
            let tab2 = TabModel()
            tab2.tabIcon = "megaphoneIcon"
            tab2.tabText = "Middle"
            
            let tab3 = TabModel()
            tab3.tabIcon = "inviteIcon"
            tab3.tabText = "Invite"
            
//            return [tab1, tab2, tab3]
            return [tab2]
        }()
    }
    let cellId = "cellId"
    
  
    lazy var tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        
        //Adding datasource and delegate to the collection view
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    let blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let bev = UIVisualEffectView(effect: blurEffect)
        return bev
    }()
    let barLine: UIView = {
        let bl = UIView()
        bl.backgroundColor = .lightGray
        return bl
    }()
    
    private func setUpViews(){
        //Adding subview elements
        addSubview(blurredEffectView)
        addSubview(tabCollectionView)
        addSubview(barLine)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: blurredEffectView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: blurredEffectView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: tabCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: tabCollectionView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: barLine)
        addConstrainsWithFormat(format: "V:[v0(0.3)]-48-|", views: barLine)
        
        //Registering the cell
        tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //Adding the subviews
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadData()
        setUpViews()
        
    }
    
    //Cell Properties
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barTabModels!.count //# of cells
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabCell //last part is so we can access the imageview
        cell.tabModel = barTabModels?[indexPath.item]
        return cell //template cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let denominator = CGFloat(barTabModels!.count)
        return CGSize(width: frame.width / denominator, height: frame.height) //size of cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //no spaces
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            print(0)
            let requestStoryboard = UIStoryboard(name: "Request", bundle: nil)
            let requestController = requestStoryboard.instantiateInitialViewController()
            let requestCell = collectionView.cellForItem(at: indexPath) as! TabCell
            requestCell.tabIcon.tintColor = UIColor.appMainColor
            homeController?.present(requestController!, animated: true, completion: nil)
        case 1:
            print(1)
        case 2:
            print(2)
        default:
            print("chuta")
        }

    }

    
    //Default code
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
















