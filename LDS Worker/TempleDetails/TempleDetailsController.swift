//
//  TempleDetailsController.swift
//  LDS Worker
//
//  Created by Campus Life Design 1 on 6/4/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class TempleDetailsController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        setUpNavigationBar()
        setUpViews()
        
        
    }
    func setUpNavigationBar() {
        
        //Title Attributes
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        self.title = "Timpanogos Temple"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(handleDoneTempleDetails))
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func handleDoneTempleDetails(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let templePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timTemple")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setUpViews() {
       view.addSubview(templePicture)
        
//        templePicture.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        templePicture.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0).isActive = true
//        templePicture.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: templePicture)
        view.addConstrainsWithFormat(format: "V:|[v0(300)]", views: templePicture)
    }
}














