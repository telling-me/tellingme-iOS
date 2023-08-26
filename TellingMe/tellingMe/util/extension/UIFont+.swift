//
//  UIFont+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

extension UIFont {
    static func fontNanum(_ fontLevel: FontLevel) -> UIFont {
        return UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
    }
}
