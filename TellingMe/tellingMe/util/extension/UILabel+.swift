//
//  UILabel+.swift
//  tellingMe
//
//  Created by 마경미 on 23.05.23.
//

import UIKit
import Foundation

extension UILabel {
    func setColorPart(text: String) {
        guard let message = self.text else { return }
        let attributedString = NSMutableAttributedString(string: message)

        let range = (message as NSString).range(of: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Logo"), range: range)

        self.attributedText = attributedString

    }
}
