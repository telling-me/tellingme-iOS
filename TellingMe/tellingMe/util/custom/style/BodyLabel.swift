//
//  BodyLabel.swift
//  tellingMe
//
//  Created by 마경미 on 21.03.23.
//

import UIKit

@IBDesignable
class Body1Bold: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFB", size: 15)
    }
}

@IBDesignable
class Body1Regular: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
    }
}

@IBDesignable
class Body2Bold: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFB", size: 14)
        self.textColor = UIColor(named: "Black")
    }
}

@IBDesignable
class Body2Regular: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: "NanumSquareRoundOTFR", size: 14)
        self.textColor = UIColor(named: "Black")
    }
}
