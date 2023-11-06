//
//  UIButton+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/10/16.
//

import UIKit

extension UIButton {
    
    /// Button 의 title 에 single line 을 긋습니다.
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
