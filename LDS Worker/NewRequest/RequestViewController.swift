

import UIKit

extension NewRequestController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        let lenght = textView.text.count
        counterLabel.text = "\(lenght)/150"
        if lenght == 0 {
            isNoteEmpty = true
        } else {
            isNoteEmpty = false
        }
        updateSendIsEnabled()
    }
    
    //Limits the text to 150 characters.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = requestDescription.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 150
    }
}

class NewRequestController: UIViewController, UINavigationBarDelegate {
    
    var isNoteEmpty = true
    var isFromEmpty = true
    var isToEmpty = true
    
    let scrollUpConstant: CGFloat = -155
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appEmptyColor
        
        addObservers()
        setUpNavigationBarStye()
        setUpViews()
        sendButton.isEnabled = false
        
        setUpDatePicker()
        
        isNoteEmpty = true
        isFromEmpty = true
        isToEmpty = true
        
    }
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc private func keyboardNotification(notification: NSNotification){
//        if let userInfo = notification.userInfo {
//            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect{
                let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
                headerTopConstraint?.constant = isKeyboardShowing ? scrollUpConstant : 0
                UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }) { (completed) in
                    
                }
//            }
//        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    private func setUpNavigationBarStye(){
        //Table View looks
        view.backgroundColor = UIColor.appEmptyColor
        
        //Navigation Controller Bar
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        
        //Title Attributes
        let titleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profilePicture: UIImageView = {
        let imageView = UIImageView.getAppProfilePictureDefaults()
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mitchel Christopherson"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let templeLabel: UILabel = {
        let label = UILabel()
        label.text = "Arizona Temple"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = label.font.withSize(13)
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "(801) 708-9428)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = label.font.withSize(13)
        return label
    }()
    
    let divider1: UIView = {
        let view = UIView.getDivider()
        return view
    }()
    
    let divider2: UIView = {
        let view = UIView.getDivider()
        return view
    }()
    
    let footLabel: UILabel = {
        let label = UILabel.getLabelFooterDefaults()
        label.text = "Your group will see this information"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel.getLabelDescriptionDefaults(text: "WRITE A NOTE:")
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel.getLabelDescriptionDefaults(text: "0/150")
//        label.textColor = UIColor.headerFooter
        return label
    }()
    
    let requestDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //done button for toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTextDone))
        toolBar.setItems([flexSpace,done], animated: false)
        textView.inputAccessoryView = toolBar
        
        return textView
    }()
    
    @objc private func handleTextDone(){
        self.view.endEditing(true)
    }
    
    let divider3: UIView = {
        let view = UIView.getDivider()
        return view
    }()
    
    let fromLabel: UILabel = {
        let label = UILabel.getLabelDescriptionDefaults(text: "FROM:")
        return label
    }()
    
    let divider4: UIView = {
        let view = UIView.getDivider()
        return view
    }()
    
    let toLabel: UILabel = {
        let label = UILabel.getLabelDescriptionDefaults(text: "TO:")
        return label
    }()
    
    let divider5: UIView = {
        let view = UIView.getDivider()
        return view
    }()
    
    let footLabel2: UILabel = {
        let label = UILabel.getLabelFooterDefaults()
        label.text = "Requests whitin 30 days only"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var headerTopConstraint: NSLayoutConstraint?
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
        
        view.addConstraint(NSLayoutConstraint(item: dateField, attribute: .top, relatedBy: .equal, toItem: requestDescription, attribute: .bottom, multiplier: 1, constant: 5))
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
    
    let dateField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .right
        field.placeholder = "..."
        return field
    }()
    
    let timeField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .right
        field.placeholder = "..."
        return field
    }()
    
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.minuteInterval = 10
        date.minimumDate = Date(timeIntervalSinceNow: 0)
        var components = DateComponents()
        components.month = 1
        date.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        date.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return date
    }()
    
    let timePicker: UIDatePicker = {
        let time = UIDatePicker()
        time.datePickerMode = UIDatePickerMode.time
        time.minuteInterval = 10
        time.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return time
    }()
    
    private func setUpDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //done button for toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDateDone))
        toolBar.setItems([flexSpace,done], animated: false)
        dateField.inputAccessoryView = toolBar
        dateField.inputView = datePicker
        
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        //done button for toolbar
        let flexSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTimeDone))
        toolBar2.setItems([flexSpace2,done2], animated: false)
        timeField.inputAccessoryView = toolBar2
        timeField.inputView = timePicker
    }
    
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            print("sending...")
        }))
        sendActionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction) in
        }))
        
        self.navigationController?.present(sendActionSheet, animated: true, completion: nil)
    }
    
    private func updateSendIsEnabled(){
        if (!isNoteEmpty && !isFromEmpty && !isToEmpty){
            sendButton.isEnabled = true
            return
        }
        sendButton.isEnabled = false
    }
    
}
