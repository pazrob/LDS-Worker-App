
import UIKit

extension HomeController: UICollectionViewDelegateFlowLayout  {
    
    func setUpCollectionView(){
        //Get access to the layout
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.appScrollBackground
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.appEmptyColor
        
        //Allows snap on horizontal cells
        collectionView?.isPagingEnabled = true
        
        //Register the video Cells
        collectionView?.register(MyRequestScroll.self, forCellWithReuseIdentifier: ID.myRequestScrollId)
        collectionView?.register(GroupRequestScroll.self, forCellWithReuseIdentifier: ID.groupRequestScrollId)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //spacing fix scrolling bar
    }
    
    
    //Bar Movement Animation
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / CGFloat(menuBar.tabs.count)
    }
    
    //Activate higlights the text/menu sliding cells
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: UICollectionView.ScrollPosition.RawValue(0)))
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBar.tabs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Present request scroll
        if indexPath.item == 0 {
            let myRequestScroll = collectionView.dequeueReusableCell(withReuseIdentifier: ID.myRequestScrollId, for: indexPath) as! MyRequestScroll
            myRequestScroll.homeController = self
            return myRequestScroll
        }
        //Present group scroll
        if indexPath.item == 1 {
            let groupRequestScroll = collectionView.dequeueReusableCell(withReuseIdentifier: ID.groupRequestScrollId, for: indexPath) as! GroupRequestScroll
            groupRequestScroll.homeController = self
            return groupRequestScroll
        }
        
        let error = collectionView.dequeueReusableCell(withReuseIdentifier: "error", for: indexPath)
        return error
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
