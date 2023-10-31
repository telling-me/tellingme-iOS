//
//  UILabel+.swift
//  tellingMe
//
//  Created by 마경미 on 23.05.23.
//

import UIKit
import Foundation

enum UIImageDirectionWithUILabel {
    case leading
    case trailing
}

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
    
    /**
     UILabel 의 Line Space 를 정합니다.
     - 기본값은 2 입니다.
     */
    func setInterlineSpacing(of spacingValue: CGFloat = 2) {
        // Check if there's any text
        guard let textString = text else { return }
        // Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)
        // Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()
        // Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue
        // Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
                          ))
        // Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }
    
    func textWithSystemImagePlaced(at direction: UIImageDirectionWithUILabel, systemImageTitle imageTitle: String, imageSize size: CGFloat, withConfiguration configuration: UIImage.SymbolConfiguration? = nil, tintColor: UIColor? = nil) {
        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageTitle, withConfiguration: configuration)?.withTintColor(tintColor ?? .black)
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        
        switch direction {
        case .leading:
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedString.append(NSAttributedString(string: textString))
            attributedText = attributedString
            sizeToFit()
        case .trailing:
            attributedString.append(NSAttributedString(string: textString))
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedText = attributedString
            sizeToFit()
        }
    }
}
