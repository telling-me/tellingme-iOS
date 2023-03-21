//
//  CaptionLabel.swift
//  tellingMe
//
//  Created by 마경미 on 21.03.23.
//

import UIKit

class CaptionLabelLight: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTF-Light", size: 12)
    }
}

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
        self.font = UIFont(name: "NanumSquareRoundOTF-Regular", size: 12)
    }
}
