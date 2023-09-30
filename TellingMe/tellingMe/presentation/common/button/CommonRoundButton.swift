//
//  CommonRoundButton.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/28.
//

import UIKit

final class CommonRoundButton: BBaseButton {

    override func setStyles() {
        self.backgroundColor = .Primary25
        self.cornerRadius = 20
        self.titleLabel?.font = .fontNanum(.H6_Bold)
    }
}

extension CommonRoundButton {
    func setTitleWithColor(text: String, color: UIColor) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
    }
    
    func setBackgroundColor(with color: UIColor) {
        self.backgroundColor = color
    }
}
