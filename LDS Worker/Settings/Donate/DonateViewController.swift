//
//  DonateViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 5/16/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let donationAmount = ["Donate $5", "Donate $10", "Donate $25", "Donate $50"]
    
    let donateTitle: UILabel = {
        let label = UILabel()
        label.text = "Only if you can!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let donateParagraph: UITextView = {
        let textView = UITextView.getAppTextNoteDefaults()
        textView.text = "Thank you for your kindness, by donating you help us to improve this service and others we are working on. But, if you cannot donate is also fine, you are already doing an amazing service in the house of the Lord!"
        return textView
    }()
    
    let donateButton: UIButton = {
        let button = UIButton.getAppButton(text: "Donate")
        button.addTarget(self, action: #selector(handleDonation), for: .touchUpInside)
        return button
    }()
    
    lazy var moneyPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return donationAmount.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return donationAmount[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpViews()

    }
    
    private func setUpViews(){
        view.addSubview(donateTitle)
        view.addSubview(donateParagraph)
        view.addSubview(moneyPicker)
        view.addSubview(donateButton)
        
        
        
        //Constraints
        view.addConstrainsWithFormat(format: "H:|-25-[v0]-25-|", views: donateTitle)
        view.addConstrainsWithFormat(format: "V:|-50-[v0]", views: donateTitle)
        
        view.addConstrainsWithFormat(format: "H:|-25-[v0]-25-|", views: donateParagraph)
        view.addConstrainsWithFormat(format: "V:[v0(100)]", views: donateParagraph)
        view.addConstraint(NSLayoutConstraint(item: donateParagraph, attribute: .top, relatedBy: .equal, toItem: donateTitle, attribute: .bottom, multiplier: 1, constant: 25))
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: moneyPicker)
        view.addConstrainsWithFormat(format: "V:[v0]", views: moneyPicker)
        view.addConstraint(NSLayoutConstraint(item: moneyPicker, attribute: .top, relatedBy: .equal, toItem: donateParagraph, attribute: .bottom, multiplier: 1, constant: 10))
        
        view.addConstrainsWithFormat(format: "H:[v0(250)]", views: donateButton)
        view.addConstrainsWithFormat(format: "V:[v0(50)]", views: donateButton)
        view.addConstraint(NSLayoutConstraint(item: donateButton, attribute: .top, relatedBy: .equal, toItem: moneyPicker, attribute: .bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: donateButton, attribute: .centerX, relatedBy: .equal, toItem: moneyPicker, attribute: .centerX, multiplier: 1, constant: 0))
    }

    
    @objc private func handleDonation(){
        print("Donating")
        let actionAlert = UIAlertController(title: "Thank you Katia!", message: "This really means a lot", preferredStyle: .alert)
        actionAlert.addAction(UIAlertAction(title: "You are welcome!", style: .default, handler: nil))
        self.navigationController?.present(actionAlert, animated: true, completion: nil)
    }
}






