//
//  DropDownTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 30.03.23.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    static let id = "dropDownTableViewCell"
    var label: Body1Regular = {
        let label = Body1Regular()
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
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    func getCell() -> String {
        return label.text ?? ""
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? UIColor(named: "Side300") : UIColor(named: "Side200")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
      super.setHighlighted(highlighted, animated: animated)
      self.backgroundColor = highlighted ? UIColor(named: "Side300") : UIColor(named: "Side200")
    }
}
