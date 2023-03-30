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
    
    public func yearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
}
