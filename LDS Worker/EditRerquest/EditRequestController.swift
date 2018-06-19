//
//  RequestController+Extension.swift
//  LDS Worker
//
//  Created by Robinson Paz 1 on 6/1/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

class EditRequestController: UIViewController, UINavigationBarDelegate {
    
    var requestToEdit: NewRequestModel?
    var isNoteEmpty = true
    var isFromEmpty = true
    var isToEmpty = true
    let scrollUpConstant: CGFloat = -155
    var headerTopConstraint: NSLayoutConstraint?
    @IBOutlet weak var sendButton: UIBarButtonItem?
    
    private func loadRequestToEdit(checkRequest toEdit: NewRequestModel?){
        if let editRequest = toEdit {
            if let note = editRequest.note{
                counterLabel.text = "\(note.count)/150"
                requestDescription.text = note
            }
            if let from = editRequest.fromDate{
                dateField.text = from
            }
            if let to = editRequest.toDate{
                timeField.text = to
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        addObservers()
        setUpNavigationBar()
        setUpViews()
        setUpToolBars()
        joinFieldsAndPickers()
        
        
        loadRequestToEdit(checkRequest: requestToEdit)
    }
    
    
    
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Implements observers action
    @objc private func keyboardNotification(notification: NSNotification){
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        headerTopConstraint?.constant = isKeyboardShowing ? scrollUpConstant : 0
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    
    let headerView = UIView.getContainer()
    let bodyView = UIView.getContainer()
    let profilePicture = UIImageView.getProfileFrame(with: "profile")
    let nameLabel = UILabel.getH2(text: "Mitchel Christopherson")
    let templeLabel = UILabel.getH4(text: "Arizona Temple")
    let phoneLabel = UILabel.getH4(text: "(801) 708-9428)")
    
    let divider1 = UIView.getDivider()
    let divider2 = UIView.getDivider()
    let divider3 = UIView.getDivider()
    let divider4 = UIView.getDivider()
    let divider5 = UIView.getDivider()
    
    let footLabel = UILabel.getLabelFooterDefaults(text: "Your group will see this information")
    let noteLabel = UILabel.getLabelDescriptionDefaults(text: "WRITE A NOTE:")
    let counterLabel = UILabel.getLabelDescriptionDefaults(text: "0/150")
    let requestDescription = UITextView.getH2(isEditable: true)
    
    let fromLabel = UILabel.getLabelDescriptionDefaults(text: "FROM:")
    let toLabel = UILabel.getLabelDescriptionDefaults(text: "TO:")
    
    let dateField = UITextField.getPicker()
    let timeField = UITextField.getPicker()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker.getDatePicker()
        date.datePickerMode = UIDatePickerMode.dateAndTime
        date.minimumDate = Date(timeIntervalSinceNow: 0)
        var components = DateComponents()
        components.month = 1
        date.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        return date
    }()
    let timePicker: UIDatePicker = {
        let time = UIDatePicker.getDatePicker()
        time.datePickerMode = UIDatePickerMode.time
        return time
    }()
    
    let footLabel2 = UILabel.getLabelFooterDefaults(text: "Requests whitin 30 days only")
    
    //Sets up all views
    private func setUpViews(){
        requestDescription.delegate = self
        requestDescription.isScrollEnabled = false
        
        view.addSubview(headerView)
        headerView.addSubview(divider1)
        view.addSubview(footLabel)
        view.addSubview(bodyView)
        headerView.addSubview(profilePicture)
        headerView.addSubview(nameLabel)
        headerView.addSubview(templeLabel)
        headerView.addSubview(phoneLabel)
        
        bodyView.addSubview(divider2)
        bodyView.addSubview(noteLabel)
        bodyView.addSubview(counterLabel)
        bodyView.addSubview(requestDescription)
        bodyView.addSubview(divider3)
        bodyView.addSubview(fromLabel)
        bodyView.addSubview(dateField)
        bodyView.addSubview(divider4)
        bodyView.addSubview(toLabel)
        bodyView.addSubview(timeField)
        bodyView.addSubview(divider5)
        
        view.addSubview(footLabel2)
        
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: headerView)
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        headerTopConstraint?.isActive = true
        view.addConstrainsWithFormat(format: "V:[v0(140)]", views: headerView)
        
        view.addConstrainsWithFormat(format: "H:|-14-[v0(100)]", views: profilePicture)
        view.addConstrainsWithFormat(format: "V:|-20-[v0(100)]", views: profilePicture)
        
        view.addConstrainsWithFormat(format: "H:|-130-[v0]|", views: nameLabel)
        view.addConstrainsWithFormat(format: "V:|-40-[v0]", views: nameLabel)
        
        templeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: templeLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        phoneLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: phoneLabel, attribute: .top, relatedBy: .equal, toItem: templeLabel, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider1)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]|", views: divider1)
        
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: footLabel)
        view.addConstraint(NSLayoutConstraint(item: footLabel, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 3))
        
        view.addConstraint(NSLayoutConstraint(item: bodyView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 30))
        view.addConstraint(NSLayoutConstraint(item: bodyView, attribute: .bottom, relatedBy: .equal, toItem: toLabel, attribute: .bottom, multiplier: 1, constant: 20))
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: bodyView)
        view.addConstrainsWithFormat(format: "V:[v0]", views: bodyView)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider2)
        view.addConstrainsWithFormat(format: "V:|[v0(0.3)]", views: divider2)
        
        view.addConstrainsWithFormat(format: "H:|-14-[v0]", views: noteLabel)
        view.addConstrainsWithFormat(format: "V:|-20-[v0]", views: noteLabel)
        
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: counterLabel)
        view.addConstrainsWithFormat(format: "V:|-20-[v0]", views: counterLabel)
        
        view.addConstraint(NSLayoutConstraint(item: requestDescription, attribute: .top, relatedBy: .equal, toItem: noteLabel, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: requestDescription)
        requestDescription.heightAnchor.constraint(equalToConstant: 50)
        
        view.addConstraint(NSLayoutConstraint(item: divider3, attribute: .top, relatedBy: .equal, toItem: requestDescription, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider3)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider3)
        
        view.addConstraint(NSLayoutConstraint(item: fromLabel, attribute: .top, relatedBy: .equal, toItem: requestDescription, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: fromLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: fromLabel)
        
        view.addConstraint(NSLayoutConstraint(item: dateField, attribute: .top, relatedBy: .equal, toItem: divider3, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: dateField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: dateField)
        
        view.addConstraint(NSLayoutConstraint(item: divider4, attribute: .top, relatedBy: .equal, toItem: fromLabel, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]|", views: divider4)
        view.addConstrainsWithFormat(format: "V:[v0(0.3)]", views: divider4)
        
        view.addConstraint(NSLayoutConstraint(item: toLabel, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: toLabel)
        view.addConstrainsWithFormat(format: "V:[v0]", views: toLabel)
        
        view.addConstraint(NSLayoutConstraint(item: timeField, attribute: .top, relatedBy: .equal, toItem: divider4, attribute: .bottom, multiplier: 1, constant: 5))
        view.addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: timeField)
        view.addConstrainsWithFormat(format: "V:[v0(40)]", views: timeField)
        
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: divider5)
        view.addConstrainsWithFormat(format: "V:[v0(0.2)]|", views: divider5)
        
        view.addConstrainsWithFormat(format: "H:[v0]-14-|", views: footLabel2)
        view.addConstraint(NSLayoutConstraint(item: footLabel2, attribute: .top, relatedBy: .equal, toItem: bodyView, attribute: .bottom, multiplier: 1, constant: 3))
    }
    
    private func setUpToolBars(){
        //Toolbar for requestDescription
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTextDone))
        toolBar.setItems([flexSpace,done], animated: false)
        requestDescription.inputAccessoryView = toolBar
    }
    
    private func joinFieldsAndPickers(){
        //date field and picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDateDone))
        toolBar.setItems([flexSpace,done], animated: false)
        dateField.inputAccessoryView = toolBar
        dateField.inputView = datePicker
        
        //time field and picker
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        let flexSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTimeDone))
        toolBar2.setItems([flexSpace2,done2], animated: false)
        timeField.inputAccessoryView = toolBar2
        timeField.inputView = timePicker
    }
    
    //Handlers
    @objc private func handleDateDone(){
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        formater.dateFormat = "E, MMM d'    'h:mm a"
        let dateString = formater.string(from: datePicker.date)
        
        dateField.text = dateString
        self.view.endEditing(true)
        if(dateField.text?.count != 0){
            isFromEmpty = false
            updateSendIsEnabled()
        }
    }
    @objc private func handleTimeDone(){
        let formater = DateFormatter()
        formater.dateStyle = .none
        formater.timeStyle = .short
        formater.dateFormat = "h:mm a"
        let dateString = formater.string(from: timePicker.date)
        
        timeField.text = dateString
        self.view.endEditing(true)
        if(timeField.text?.count != 0){
            isToEmpty = false
            updateSendIsEnabled()
        }
    }
    @IBAction func handleCancel(_ sender: UIBarButtonItem) {
        if isNoteEmpty {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        let cancelActionSheet = UIAlertController(title: "Are you sure you want to Cancel?", message: nil, preferredStyle: .actionSheet)
        cancelActionSheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action: UIAlertAction) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }))
        cancelActionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        self.navigationController?.present(cancelActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func handleSend(_ sender: UIBarButtonItem) {
        let sendActionSheet = UIAlertController(title: "Request will be shared with your temple group", message: nil, preferredStyle: .actionSheet)
        sendActionSheet.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action: UIAlertAction) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }))
        sendActionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction) in
        }))
        
        self.navigationController?.present(sendActionSheet, animated: true, completion: nil)
    }
    @objc private func handleTextDone(){
        self.view.endEditing(true)
    }
    
    internal func updateSendIsEnabled(){
        if (!isNoteEmpty && !isFromEmpty && !isToEmpty){
            sendButton?.isEnabled = true
            return
        }
        sendButton?.isEnabled = false
    }
    
    //Frees observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
