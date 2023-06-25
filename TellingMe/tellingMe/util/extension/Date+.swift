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
    
    func getQuestionDate() -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: currentDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")

        if let hour = components.hour {
            if hour < 6 {
                guard let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) else {
                    return nil
                }
                return dateFormatter.string(from: yesterday)
            } else {
                return dateFormatter.string(from: currentDate)
            }
        }
        return nil
    }
}
