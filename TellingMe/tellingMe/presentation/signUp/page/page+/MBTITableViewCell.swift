//
//  MBTITableViewCell.swift
//  tellingMe
//
//  Created by 마경미 on 30.03.23.
//

import UIKit

class MBTITableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
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
