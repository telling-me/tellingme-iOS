//
//  Date+.swift
//  tellingMe
//
//  Created by 마경미 on 31.03.23.
//

import Foundation

extension Date {
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!

        return formatter.string(from: self)
    }

    public func todayFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }

    public func dateFormat(yesterday: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }

    public func yearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }

    public func monthFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        let str = formatter.string(from: self)
        return str
    }

    func getQuestionDate() -> String {
        let calendar = Calendar.current
        let sixAMComponents = DateComponents(hour: 6)
        let sixAMDate = calendar.nextDate(after: self, matching: sixAMComponents, matchingPolicy: .nextTimePreservingSmallerComponents, repeatedTimePolicy: .first, direction: .backward)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")

        if self < sixAMDate {
            let yesterday = calendar.date(byAdding: .day, value: -1, to: self)!
            return dateFormatter.string(from: yesterday)
        } else {
            return dateFormatter.string(from: self)
        }
    }
}
