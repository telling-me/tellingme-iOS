//
//  Array+.swift
//  tellingMe
//
//  Created by 마경미 on 07.04.23.
//

import Foundation

extension Array {
    func intArraytoString() -> String {
        var string = "["
        for i in 0..<self.count {
            string += "\(self[i])"
            if i != self.count - 1 {
                string += ", "
            }
        }
        string += "]"
        return string
    }

    func intArraytoDate() -> String? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self[0] as? Int
        dateComponents.month = self[1] as? Int
        dateComponents.day = self[2] as? Int

        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        }

        return nil
    }
    
    func intArraytoDate2() -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = self[0] as? Int
        dateComponents.month = self[1] as? Int
        dateComponents.day = self[2] as? Int

        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        }

        return "1999.09.01"
    }
}
