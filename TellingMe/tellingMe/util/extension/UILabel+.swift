//
//  UILabel+.swift
//  tellingMe
//
//  Created by 마경미 on 23.05.23.
//

import UIKit
import Foundation

extension UILabel {
    func setColorPart(text: String, color: UIColor) {
        guard let message = self.text else { return }
        let attributedString = NSMutableAttributedString(string: message)

        let range = (message as NSString).range(of: text)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)

        self.attributedText = attributedString
    }
    
    func setBoldPart(text: String, font: UIFont) {
        guard let message = self.text else { return }
        let attributedString = NSMutableAttributedString(string: message)

        let range = (message as NSString).range(of: text)
        attributedString.addAttribute(.font, value: font, range: range)

        self.attributedText = attributedString
    }
}
