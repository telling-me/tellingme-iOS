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
    
    // MARK: Date()를 yyyy년 MM월 dd일 포맷으로 리턴하는 메서드
    public func todayFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    // MARK: Date()를 yyyy/MM/dd일 포맷으로 리턴하는 메서드
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
    
    // MARK: 질문에 맞는 날짜 yyyy-MM-dd 형식으로 반환합니다.
    // 질문이 6시마다 초기화되기 때문에 새벽 12시부터 6시까지는 이전 날짜를 반환해야합니다.
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
    
    func getDashString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: self)
    }
}
