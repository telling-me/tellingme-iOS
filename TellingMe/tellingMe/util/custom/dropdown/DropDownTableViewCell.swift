//
//  DropDownTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 30.03.23.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    static let id = "dropDownTableViewCell"
    let label = Body1Regular()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(text: String) {
        label.text = text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        self.selectionStyle = .none
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? UIColor(named: "Side300") : UIColor(named: "Side200")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        print(highlighted)
      super.setHighlighted(highlighted, animated: animated)
      self.backgroundColor = highlighted ? UIColor(named: "Side300") : UIColor(named: "Side200")
    }

}
