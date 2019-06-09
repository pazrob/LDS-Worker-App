

import UIKit
import Firebase

extension MessageScroll : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setUpMessagesCollection() {
        
        addSubview(messagesCollectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: messagesCollectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: messagesCollectionView)
    }
    
    //If Messages array is empty, then return 1: This for the empty cell to work
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.isEmpty ? 1 : messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if messages.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellId, for: indexPath) as! EmptyCollectionCell
            cell.imageView.image = UIImage(named: "messagesBackground")
            cell.textView.text = EmptyStateCase.subTitle.rawValue
            cell.label.text = EmptyStateCase.mainTitle.rawValue
            cell.button.setTitle(EmptyStateCase.buttonText.rawValue, for: .normal)
            cell.button.addTarget(self, action: #selector(selectLabel), for: .touchUpInside)
            cell.button.isUserInteractionEnabled = true
            cell.isUserInteractionEnabled = true
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myRequestCellId, for: indexPath) as! MessageCell
        cell.theMessage = messages[indexPath.item]
        return cell
    }
    
    //Brings Contact Controller
    @objc func selectLabel() {
        homeController?.handleContactsButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if messages.isEmpty {
            return CGSize(width: messagesCollectionView.frame.width,height: messagesCollectionView.frame.height - 200)
        }
        return CGSize(width: messagesCollectionView.frame.width,height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if messages.isEmpty {
            return
        }
        
        if let recipientUID = messages[indexPath.item].getChatReceipientUID() {
            self.homeController?.pushMessageDetailController(with: recipientUID)
        }
    }
    
    
}

//Header
extension MessageScroll {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        if messages.isEmpty {
            header.headerLabel.text = ""
        } else {
            header.headerLabel.text = "MESSAGES"
        }
    
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
}
