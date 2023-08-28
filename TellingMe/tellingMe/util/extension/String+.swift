//
//  String+.swift
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
    
    /**
     String 을 "2023.08.01" 형식으로 바꿔 String 으로 반환합니다
     */
    func stringDateToFormattedString() -> String {
        let year = String(self[self.startIndex..<self.index(self.startIndex, offsetBy: 4)])
        let month = String(self[self.index(self.startIndex, offsetBy: 5)..<self.index(self.startIndex, offsetBy: 7)])
        let day = String(self[self.index(self.startIndex, offsetBy: 8)..<self.index(self.startIndex, offsetBy: 10)])
        let result = year + "." + month + "." + day
        return result
    }
}
