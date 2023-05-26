//
//  PullDownTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 22.05.23.
//

import Foundation
import UIKit

class PullDownTableViewCell: UITableViewCell {
    static let id = "pullDownTableViewCell"
    var label: Body2Regular = {
        let label = Body2Regular()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(text: String) {
        contentView.addSubview(label)
        label.text = text
        label.sizeToFit()
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(named: "Side200")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.backgroundColor = selected ? UIColor(named: "Side300") : UIColor(named: "Side200")
//    }
//
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//      super.setHighlighted(highlighted, animated: animated)
//      self.backgroundColor = highlighted ? UIColor(named: "Side300") : UIColor(named: "Side200")
//    }
}
