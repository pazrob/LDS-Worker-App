//
//  SettingCell.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    let detailArrow : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var cellSwitch : UISwitch = {
        let switchItem = UISwitch()
        switchItem.onTintColor = UIColor.appMainColor
        switchItem.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
        return switchItem
    }()
    
    @objc func switchAction(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: UserDefaultsKeys.notificationOn.rawValue)
    }
    
    override func setUpViews() {
        backgroundColor = UIColor.white
        
        addSubview(cellLabel)
        addSubview(detailArrow)
        addSubview(cellSwitch)
        
        addConstrainsWithFormat(format: "V:[v0]", views: cellSwitch)
        addConstrainsWithFormat(format: "H:[v0]-14-|", views: cellSwitch)
        cellSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        addConstrainsWithFormat(format: "V:|[v0]|", views: cellLabel)
        addConstrainsWithFormat(format: "H:|-14-[v0]|", views: cellLabel)
        
        addConstrainsWithFormat(format: "V:[v0(15)]", views: detailArrow)
        addConstrainsWithFormat(format: "H:[v0(15)]-14-|", views: detailArrow)
        detailArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
