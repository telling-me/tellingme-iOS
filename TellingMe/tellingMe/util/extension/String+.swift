//
//  KoreanTextField.swift
//  tellingMe
//
//  Created by 마경미 on 28.03.23.
//

import UIKit

extension String {
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[가-힣ㄱ-ㅎㅏ-ㅣ]$", options: .caseInsensitive)
            if regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: self.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    func stringToInt() -> [Int] {
        let digits = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let numbers = digits.compactMap { Int($0) }
        return numbers
    }
}
