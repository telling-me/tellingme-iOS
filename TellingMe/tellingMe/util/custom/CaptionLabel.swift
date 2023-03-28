//
//  CaptionLabel.swift
//  tellingMe
//
//  Created by 마경미 on 21.03.23.
//

import UIKit

@IBDesignable
class CaptionLabelBold: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
    }
}

@IBDesignable
class CpationLabelRegular: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
    }
}
