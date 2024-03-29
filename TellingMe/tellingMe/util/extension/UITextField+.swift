//
//  UITextField+.swift
//  tellingMe
//
//  Created by 마경미 on 28.03.23.
//

import Foundation
import UIKit

extension UITextField {
    private func getKeyboardLanguage() -> String? {
        return "ko-KR"
    }

    open override var textInputMode: UITextInputMode? {
        if let language = getKeyboardLanguage() {
            for inputMode in UITextInputMode.activeInputModes where inputMode.primaryLanguage! == language {
                return inputMode
            }
        }
        return super.textInputMode
    }
}
