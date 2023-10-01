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
    // MARK: - Primary Colors
    static var Primary25: UIColor {
        return UIColor(hex: "#F2FDF6")
    }
    static var Primary50: UIColor {
        return UIColor(hex: "#E5FCED")
    }
    static var Primary100: UIColor {
        return UIColor(hex: "#CBF9DC")
    }
    static var Primary200: UIColor {
        return UIColor(hex: "#B0F5CA")
    }
    static var Primary300: UIColor {
        return UIColor(hex: "#A3F4C1")
    }
    static var Primary400: UIColor {
        return UIColor(hex: "#7CEFA7")
    }
    static var Primary500: UIColor {
        return UIColor(hex: "#7DCE9B")
    }
    static var Primary600: UIColor {
        return UIColor(hex: "#7EB894")
    }
    static var Primary700: UIColor {
        return UIColor(hex: "#57A775")
    }
    static var Primary800: UIColor {
        return UIColor(hex: "#326043")
    }
    static var Primary900: UIColor {
        return UIColor(hex: "#254832")
    }
}

extension UIColor {
    // MARK: - Secondary Colors
    static var Secondary25: UIColor {
        return UIColor(hex: "#F4FBFE")
    }
    static var Secondary50: UIColor {
        return UIColor(hex: "#E9F6FD")
    }
    static var Secondary100: UIColor {
        return UIColor(hex: "#D2EDFB")
    }
    static var Secondary200: UIColor {
        return UIColor(hex: "#BCE5F8")
    }
    static var Secondary300: UIColor {
        return UIColor(hex: "#A5DCF6")
    }
    static var Secondary400: UIColor {
        return UIColor(hex: "#8FD3F4")
    }
    static var Secondary500: UIColor {
        return UIColor(hex: "#8BBAD1")
    }
    static var Secondary600: UIColor {
        return UIColor(hex: "#8599A3")
    }
    static var Secondary700: UIColor {
        return UIColor(hex: "#6494AB")
    }
    static var Secondary800: UIColor {
        return UIColor(hex: "#486A7A")
    }
}

extension UIColor {
    // MARK: - Side Colors
    static var Side100: UIColor {
        return UIColor(hex: "#FFFDFA")
    }
    static var Side200: UIColor {
        return UIColor(hex: "#F9F7F2")
    }
    static var Side300: UIColor {
        return UIColor(hex: "#E6E4E2")
    }
    static var Side400: UIColor {
        return UIColor(hex: "#СССАС8")
    }
    static var Side500: UIColor {
        return UIColor(hex: "#807F7D")
    }
}

extension UIColor {
    // MARK: - Logo and Error Colors
    static var Logo: UIColor {
        return UIColor(hex: "#07BEB8")
    }
    static var Sub100: UIColor {
        return UIColor(hex: "#F9F2DF")
    }
    static var Error100: UIColor {
        return UIColor(hex: "#FFF5F4")
    }
    static var Error200: UIColor {
        return UIColor(hex: "#FFDCDA")
    }
    static var Error300: UIColor {
        return UIColor(hex: "#FF7A72")
    }
    static var Error400: UIColor {
        return UIColor(hex: "#FF574c")
    }
    static var Error500: UIColor {
        return UIColor(hex: "#FF3838")
    }
}

extension UIColor {
    static var Black: UIColor {
        return UIColor(hex: "#333835")
    }
    static var Gray0: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    static var Gray1: UIColor {
        return UIColor(hex: "#EEF1F1")
    }
    static var Gray2: UIColor {
        return UIColor(hex: "#CCD1CE")
    }
    static var Gray3: UIColor {
        return UIColor(hex: "#B3B9B5")
    }
    static var Gray4: UIColor {
        return UIColor(hex: "#99A29D")
    }
    static var Gray5: UIColor {
        return UIColor(hex: "#808983")
    }
    static var Gray6: UIColor {
        return UIColor(hex: "#666F6A")
    }
    static var Gray7: UIColor {
        return UIColor(hex: "#4D534F")
    }
    static var Gray8: UIColor {
        return UIColor(hex: "#404642")
    }
}

extension UIColor {
    // MARK: - Emotion Colors
    static var Emotion100: UIColor {
        return UIColor(hex: "#FFE26C")
    }
    static var Emotion200: UIColor {
        return UIColor(hex: "#B1F981")
    }
    static var Emotion300: UIColor {
        return UIColor(hex: "#87F0AE")
    }
    static var Emotion400: UIColor {
        return UIColor(hex: "#9B9BFF")
    }
    static var Emotion500: UIColor {
        return UIColor(hex: "#A0E4F5")
    }
    static var Emotion600: UIColor {
        return UIColor(hex: "#FAB0CF")
    }
    
    // MARK: - Etc
    static var EBookNavigationColor: UIColor {
        return UIColor(hex: "#FFEDA4")
    }
}
