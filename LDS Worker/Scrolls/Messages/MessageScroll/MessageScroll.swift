
import UIKit

class MessageScroll: BaseCell {
    
    var homeController : HomeController?
    var messages = [MessageModel]()
    let myRequestCellId = "myRequestCellId"
    let headerId = "headerId"
    let emptyCellId = "emptyCellId"
    
    enum EmptyStateCase: String {
        case mainTitle = "No Messages Yet"
        case subTitle = "Looking a little lonely here \n Reach out and talk to someone"
        case buttonText = "Reach Out"
    }
    
    lazy var messagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        cv.backgroundColor = UIColor.appEmptyColor
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.register(MessageCell.self, forCellWithReuseIdentifier: myRequestCellId)
        cv.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: emptyCellId)
        cv.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        //Ready to catch messages changes
        addMessageObserver()
        
        //Collection
        setUpMessagesCollection()
        
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}




