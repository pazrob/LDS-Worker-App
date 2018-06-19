//
//  BaseCell.swift
//  TempleWorker2
//
//  Created by Campus Life Design 1 on 5/8/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    //Will call automaticly in all children
    func setUpViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
