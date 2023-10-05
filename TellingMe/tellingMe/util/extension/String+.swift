//
//  String+.swift
//  tellingMe
//
//  Created by 마경미 on 28.03.23.
//

import UIKit

extension String {
    /**
     한글만 입력한 경우 true, 그렇지 않은 경우 false를 반환합니다.
     닉네임 검사에 사용됩니다.  (회원가입 / 내 정보 수정)
     */
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
    
    /**
     "2023-08-01" 을 [2023, 08, 01] 형식으로 바꿉니다.
     */
    func stringDateToDividedArray() -> [Int] {
        var result: [Int] = []
        let year = String(self[self.startIndex..<self.index(self.startIndex, offsetBy: 4)])
        let month = String(self[self.index(self.startIndex, offsetBy: 5)..<self.index(self.startIndex, offsetBy: 7)])
        let day = String(self[self.index(self.startIndex, offsetBy: 8)..<self.index(self.startIndex, offsetBy: 10)])
        guard let yearInt = Int(year), let monthInt = Int(month), let dayInt = Int(day) else {
            return [2023, 01, 01]
        }
        
        result.append(yearInt)
        result.append(monthInt)
        result.append(dayInt)
        return result
    }
    
    /**
     "2023-08-01"  Date 형식으로 바꿉니다.
     */
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
