//
//  MessageDC+CollectionFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/29/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit


extension MessageDetailController {
    
    func setUpCollectionView() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(MessageTextCell.self, forCellWithReuseIdentifier: messageTextCellId)
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        self.collectionView?.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageTextCellId, for: indexPath) as! MessageTextCell
        cell.message = messages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        var height: CGFloat = 0
        
        if let text = messages[indexPath.item].text {
            height = estimatedFrameForText(text: text).height + 20
        }
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    func estimatedFrameForText(text: String) -> CGRect{
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
}
