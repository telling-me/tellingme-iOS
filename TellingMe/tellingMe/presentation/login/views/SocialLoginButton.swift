//
//  LoginButton.swift
//  tellingMe
//
//  Created by 마경미 on 22.03.23.
//

import UIKit

class SocialLoginButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func initializeLabel(name: String, color: UIColor) {
        self.setTitle("\(name)로 계속하기", for: .normal)
        self.backgroundColor = color
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false

        if name == "Apple" {
            self.setTitleColor(UIColor.white, for: .normal)
            self.setImage(UIImage(named: "apple"), for: .normal)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 12)
        }
    }
}
