//
//  SettingTableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 11.05.23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let id = "settingTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? UIColor(named: "Side200") : UIColor(named: "Side100")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
      super.setHighlighted(highlighted, animated: animated)
      self.backgroundColor = highlighted ? UIColor(named: "Side200") : UIColor(named: "Side100")
    }
}
