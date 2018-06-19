
import UIKit

class HeaderCell: BaseCell{
    
    let headerLabel: UILabel = {
        return UILabel.getLabelHeaderDefaults()
    }()
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(headerLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstrainsWithFormat(format: "V:[v0]-10-|", views: headerLabel)
    }
}

class FooterCell: BaseCell{
    
    let footerLabel = UILabel.getLabelFooterDefaults(text: "")
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(footerLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        addConstrainsWithFormat(format: "H:|-14-[v0]-14-|", views: footerLabel)
        addConstrainsWithFormat(format: "V:|-2-[v0]", views: footerLabel)
    }
}
