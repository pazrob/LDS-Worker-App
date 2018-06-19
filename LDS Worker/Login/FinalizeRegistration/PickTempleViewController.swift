//
//  PickPhotoViewController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/7/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class PickTempleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "templeIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var skipLabel: UILabel = {
        let label = UILabel()
        label.text = "Skip"
        label.textColor = UIColor.rgb(red: 0, green: 122, blue: 255)
        label.font = label.font.withSize(16)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSkip)))
        
        return label
    }()
    @objc func handleSkip(){
        print("Starting skip...")
        let pickPhotoViewController = PickPhotoViewController()
        self.navigationController?.pushViewController(pickPhotoViewController, animated: true)
    }
    
    let explainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Find your Temple"
        label.textColor = UIColor.black
        label.font = label.font.withSize(30)
        return label
    }()
    let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = textField.font?.withSize(14)
        textField.clearButtonMode = .whileEditing
        var leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        leftIcon.image = UIImage(named: "lupa")?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = UIColor.gray
        leftIcon.contentMode = .scaleAspectFit
        textField.leftView = leftIcon
        textField.leftViewMode = UITextFieldViewMode.always
        textField.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    override var prefersStatusBarHidden: Bool {
            return true
    }
    
    private func setUpViews(){
        view.backgroundColor = UIColor.appEmptyColor
        
        view.addSubview(skipLabel)
        view.addSubview(icon)
        view.addSubview(explainerLabel)
        view.addSubview(searchField)
        
        view.addConstrainsWithFormat(format: "V:|-40-[v0]", views: skipLabel)
        view.addConstrainsWithFormat(format: "H:[v0]-20-|", views: skipLabel)

        
        view.addConstrainsWithFormat(format: "V:|-30-[v0(100)]", views: icon)
        view.addConstrainsWithFormat(format: "H:[v0(100)]", views: icon)
        view.addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstrainsWithFormat(format: "V:[v0]", views: explainerLabel)
        view.addConstrainsWithFormat(format: "H:[v0]", views: explainerLabel)
        view.addConstraint(NSLayoutConstraint(item: explainerLabel, attribute: .top, relatedBy: .equal, toItem: icon, attribute: .bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: explainerLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 10))

        view.addConstrainsWithFormat(format: "V:[v0(28)]", views: searchField)
        view.addConstrainsWithFormat(format: "H:|-30-[v0]-30-|", views: searchField)
        view.addConstraint(NSLayoutConstraint(item: searchField, attribute: .top, relatedBy: .equal, toItem: explainerLabel, attribute: .bottom, multiplier: 1, constant: 30))
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
