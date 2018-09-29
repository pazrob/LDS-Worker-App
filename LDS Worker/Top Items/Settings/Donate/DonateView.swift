//
//  NewRequestView.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/6/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class DonateView: UIView {
    
    let donationAmount = ["Donate $5", "Donate $10", "Donate $25", "Donate $50"]
    let donationText = "Thank you for your kindness, by donating you help us to improve this service and others we are working on. But, if you cannot donate is also fine, you are already doing an amazing service in the house of the Lord!"
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setUpViews()
        setUpConstraints()
    }
    
    let donateTitle: UILabel = {
        let label = UILabel()
        label.text = UITextSettings.donateTitle.rawValue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var donateParagraph: UITextView = {
        let textView = UITextView.getAppTextNoteDefaults()
        textView.text = donationText
        return textView
    }()
    
    let donateButton: UIButton = {
        let button = UIButton.getAppButton(text: UITextSettings.donate.rawValue)
        return button
    }()
    
    lazy var moneyPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
        
    func setUpViews() {
        
        addSubview(donateTitle)
        addSubview(donateParagraph)
        addSubview(moneyPicker)
        addSubview(donateButton)
    }
    
    func setUpConstraints() {
        
        addConstrainsWithFormat(format: "H:|-25-[v0]-25-|", views: donateTitle)
        addConstrainsWithFormat(format: "V:|-50-[v0]", views: donateTitle)
        
        addConstrainsWithFormat(format: "H:|-25-[v0]-25-|", views: donateParagraph)
        addConstrainsWithFormat(format: "V:[v0(100)]", views: donateParagraph)
        addConstraint(NSLayoutConstraint(item: donateParagraph, attribute: .top, relatedBy: .equal, toItem: donateTitle, attribute: .bottom, multiplier: 1, constant: 25))
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: moneyPicker)
        addConstrainsWithFormat(format: "V:[v0]", views: moneyPicker)
        addConstraint(NSLayoutConstraint(item: moneyPicker, attribute: .top, relatedBy: .equal, toItem: donateParagraph, attribute: .bottom, multiplier: 1, constant: 10))
        
        addConstrainsWithFormat(format: "H:[v0(250)]", views: donateButton)
        addConstrainsWithFormat(format: "V:[v0(40)]", views: donateButton)
        addConstraint(NSLayoutConstraint(item: donateButton, attribute: .top, relatedBy: .equal, toItem: moneyPicker, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: donateButton, attribute: .centerX, relatedBy: .equal, toItem: moneyPicker, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
