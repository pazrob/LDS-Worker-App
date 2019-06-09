
import UIKit


extension UILabel{
    
    static func getLabelHeaderDefaults() -> UILabel{
        let label = UILabel()
        label.addCharacterSpacing(spacing: 0.8)
        label.font = label.font.withSize(11)
        label.textColor = UIColor.headerFooter
        return label
    }
    
    static func getLabelFooterDefaults(text: String) -> UILabel{
        let label = UILabel()
        label.addCharacterSpacing(spacing: 0.8)
        label.font = label.font.withSize(10)
        label.textAlignment = .right
        label.textColor = UIColor.headerFooter
        label.text = text
        return label
    }
    
    static func getLabelDescriptionDefaults(text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.addCharacterSpacing(spacing: 0.8)
        label.font = label.font.withSize(13)
        label.textColor = UIColor.appDarkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func getH2(text: String) -> UILabel{
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func getH3(text: String) -> UILabel{
        let label = UILabel()
        label.textAlignment = .right
        label.font = label.font.withSize(15)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func getH4(text: String) -> UILabel{
        let label = UILabel()
        label.textAlignment = .left
        label.font = label.font.withSize(13)
        label.text = text
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func getLabelSubtitlePostedDefaults() -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.textColor = UIColor.lightGray
        return label
    }
    
    func addCharacterSpacing(spacing: Double) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
















