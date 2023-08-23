//
//  Color+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/08/23.
//

import UIKit

extension UIColor {
    
    /// Color Picker 에서 UIColor 를 고르면 Hex String 으로 변환한다.
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    
    /// Hex Code 를 입력하면 UIColor 로 반환한다.
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

extension UIColor {
        
    static var blue50: UIColor {
        return UIColor(hex: "#EEF5FF")
    }
    
    static var blue100: UIColor {
        return UIColor(hex: "#DDEBFF")
    }
    
    static var blue200: UIColor {
        return UIColor(hex: "#B4D2FF")
    }
}
